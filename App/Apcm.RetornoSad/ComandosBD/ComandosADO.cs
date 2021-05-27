using Apcm.RetornoSad.Retornos;
using System;
using System.Data;
using System.Data.SqlClient;

namespace Apcm.RetornoSad.ComandosBD
{
    internal class ComandosADO
    {
        /// <summary>
        /// Método responsável por Executar Consultas e retornar dados de forma amigável
        /// </summary>
        /// <param name="connectionString">String de conexão</param>
        /// <param name="consulta">consulta a ser realizada</param>
        /// <returns></returns>
        public RetornoConsultaBD ExecutarConsulta(string connectionString, string consulta)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(consulta, conn);
                    cmd.CommandTimeout = 0;
                    using (SqlDataAdapter adp = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adp.Fill(dt);

                        if (dt == null)
                            return new RetornoConsultaBD { Sucesso = false, Mensagem = "Não foram encontrados dados para pesquisa", TipoRetorno = 404 };

                        if (dt.Rows.Count <= 0)
                            return new RetornoConsultaBD { Sucesso = false, Mensagem = "Não foram encontrados dados para pesquisa", TipoRetorno = 404 };

                        return new RetornoConsultaBD { Sucesso = true, RetornoDt = dt, TipoRetorno = 200 };
                    }
                }
            }
            catch (Exception ex)
            {
                return new RetornoConsultaBD { Sucesso = false, Mensagem = "Erro ao obter dados. Ocorrência de exceção." + ex.Message + ex.InnerException, TipoRetorno = 500 };
            }
        }


        /// <summary>
        /// Método responsável por Executar transações com BD
        /// </summary>
        /// <param name="connectionString">String de conexão</param>
        /// <param name="consulta">consulta a ser realizada</param>
        /// <returns></returns>
        public RetornoGenerico ExecutarNonQuery(string connectionString, string consulta)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(consulta, conn))
                    {
                        cmd.CommandTimeout = 0;
                        int qtdeAfetada = cmd.ExecuteNonQuery();
                        if (qtdeAfetada == 0)
                            return new RetornoConsultaBD { Sucesso = false, Mensagem = "Não foram encontrados dados", TipoRetorno = 404 };

                        return new RetornoConsultaBD { Sucesso = true, TipoRetorno = 200, Id = qtdeAfetada };
                    }
                }
            }
            catch (Exception ex)
            {
                return new RetornoConsultaBD { Sucesso = false, Mensagem = "Erro ao executar comando. Ocorrência de exceção." + ex.Message + ex.InnerException, TipoRetorno = 500 };
            }
        }
    }
}
