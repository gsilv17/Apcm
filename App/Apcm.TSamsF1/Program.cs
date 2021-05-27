using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Apcm.TSamsF1.Data;
using Apcm.TSamsF1.Properties;

namespace Apcm.TSamsF1
{
    class Program
    {
        static bool running;

        static void Main(string[] args)
        {
            running = true;
            Task runningTask = Task.Factory.StartNew(() => Running());
            Task serviceTask = Task.Factory.StartNew(action: () => Loads());
            Task.WaitAll(serviceTask);
            running = false;
            Task.WaitAll(runningTask);
        }

        static void Running()
        {
            int maxBullets = 5;
            int countBullets = 0;
            while (running)
            {
                string bullets = new string('=', countBullets).PadRight(maxBullets, '-');
                Console.CursorLeft = 0;
                Console.Write(bullets);
                countBullets = countBullets == maxBullets ? 0 : countBullets + 1;
                Thread.Sleep(1000);
            }

            Console.Clear();
            Console.Write("Ok!");
            Thread.Sleep(500);
        }

        static void Loads()
        {
            SqlContext sql = new SqlContext();
            Db2Context db2 = new Db2Context();
            int idLoad = 0;

            try
            {
                // Fase 1
                idLoad = sql.Load(Scripts.IniciarLoad).Read<int>(0);
                bool loadInicial = sql.Load(Scripts.VerificarLoadInicial).Read<string>(0) == "S";
                string loadResult = "Ok";
                Entidade.ObterEntidades().ForEach(e => 
                { 
                    if(!Load(e, idLoad, loadInicial, sql, db2))
                    {
                        loadResult = "Erro";
                    }
                });
                sql.ExecuteNonQuery(Scripts.EncerrarLoad, loadResult, idLoad);

                // Fase 2 - Executada no Powercenter a partir de 2020-12-16T12:00:00
                // sql.ExecuteNonQuery(Scripts.TSamsF2);
            }
            catch (Exception ex)
            {
                if (idLoad > 0)
                {
                    sql.ExecuteNonQuery(Scripts.EncerrarLoad, ex.Message, idLoad);
                }
            }
            finally
            {
                sql.Dispose();
                db2.Dispose();
            }
        }

        static bool Load(Entidade entidade, int idLoad, bool loadInicial, SqlContext sql, Db2Context db2)
        {
            int idLog = 0;

            try
            {
                idLog = sql.Load(Scripts.IniciarLog, idLoad, entidade.Nome).Read<int>(0);

                if (loadInicial || !entidade.PossuiCampoDataAlteracao)
                {
                    sql.ExecuteNonQuery(entidade.Limpar());
                }

                DataTable db2Table;
                string dataAlteracao = string.Empty;
                if (!loadInicial && entidade.PossuiCampoDataAlteracao)
                {
                    dataAlteracao = sql.Load(entidade.ObterUltimaAlteracao()).Read<string>(0);
                }

                DataTable sqlTable = sql.Load(entidade.BulkTable());
                sqlTable.TableName = entidade.Nome;
                int qtd = LoadDb2(db2, entidade.SelectCount(loadInicial), dataAlteracao).Read<int>(0);
                int qtdLidas = 0;
                if (qtd <= Settings.Default.TamanhoPacote)
                {
                    db2Table = LoadDb2(db2, entidade.SelectAll(loadInicial), dataAlteracao);
                    qtdLidas = db2Table.Rows.Count;
                    MoveDataDb2ToSql(db2Table, sqlTable, idLoad);
                    sql.ExecuteBulk(sqlTable);
                    sqlTable.Clear();
                    sqlTable = null;
                }
                else
                {
                    decimal pages = Math.Ceiling(qtd / Convert.ToDecimal(Settings.Default.TamanhoPacote));
                    for (int page = 0; page < pages; page++)
                    {
                        int maiorQue = (page * Settings.Default.TamanhoPacote);
                        int menorIgualQue = maiorQue + Settings.Default.TamanhoPacote;
                        db2Table = db2.Load(entidade.SelectPage(loadInicial, maiorQue, menorIgualQue), dataAlteracao);
                        qtdLidas += db2Table.Rows.Count;
                        MoveDataDb2ToSql(db2Table, sqlTable, idLoad);
                        sql.ExecuteBulk(sqlTable);
                        sqlTable.Clear();
                    }
                    sqlTable = null;
                }

                string msg = string.Empty;

                if (!loadInicial && entidade.PossuiCampoDataAlteracao)
                {
                    int removidos = sql.ExecuteNonQuery(entidade.RemoverAntigos(), idLoad);
                    if(qtdLidas > 0)
                    {
                        int novos = qtdLidas - removidos;
                        int atualizados = qtdLidas - novos;
                        msg = $"Info: Novos: {novos}, Atualizados: {atualizados}. ";
                    }
                }
                msg = string.IsNullOrEmpty(msg) ? "Info: Ok" : msg;
                msg = qtd == qtdLidas ? msg : $"Atenção: Houve alteração na orígem durante a leitura, esperados {qtd}, lidos {qtdLidas}. {msg}";
                sql.ExecuteNonQuery(Scripts.FinalizarLog, msg, qtdLidas, idLog);
                return true;
            }
            catch (Exception ex)
            {
                if (idLog > 0)
                {
                    sql.ExecuteNonQuery(Scripts.FinalizarLog, $"Erro: {ex.Message}", 0, idLog);
                }

                return false;
            }
        }

        static void MoveDataDb2ToSql(DataTable db2Table, DataTable sqlTable, int idLoad)
        {
            string columnName = string.Empty, db2ColumnType = string.Empty, sqlColumnType = string.Empty;
            object db2Value = string.Empty;
            try
            {
                foreach (DataRow db2Row in db2Table.Rows)
                {
                    DataRow sqlRow = sqlTable.NewRow();
                    sqlRow["IdLoad"] = idLoad;
                    foreach (DataColumn db2Column in db2Table.Columns)
                    {
                        columnName = db2Column.ColumnName;
                        if (columnName != "ROW_NUMBER")
                        {
                            db2ColumnType = db2Column.DataType.Name;
                            sqlColumnType = sqlTable.Columns[columnName].DataType.Name;
                            db2Value = db2Row[columnName];
                            sqlRow[columnName] = db2Value;
                        }
                    }
                    sqlTable.Rows.Add(sqlRow);
                }

                db2Table.Clear();
                db2Table = null;
            }
            catch (Exception ex)
            {
                throw new Exception($"Falha na coluna {columnName} do tipo {db2ColumnType} para o tipo {sqlColumnType} com o valor {db2Value.ToString()}, erro: {ex.Message}");
            }
        }

        static DataTable LoadDb2(Db2Context db2, string selectCommand, string dataAlteracao)
        {
            if (string.IsNullOrEmpty(dataAlteracao))
            {
                return db2.Load(selectCommand);
            }
            else
            {
                return db2.Load(selectCommand, dataAlteracao);
            }
        }
    }
}
