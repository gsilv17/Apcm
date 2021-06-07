using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;
using Apcm.Service.Data;
using Apcm.Service.Item;
using Apcm.Service.Lote;
using Apcm.Service.Mapa;
using Apcm.Service.Sad;
using System.Threading;
using Apcm.Service.EstruturaMercadologica;
using Apcm.Service.AppUser;
using System.Web.Script.Serialization;
using System.Collections;
using Apcm.Service.Log;

namespace Apcm.Service.Carrinho
{
    internal sealed class CarrinhoService : DataService<CarrinhoRepository>, ICarrinhoService
    {
        private IMapaService MapaService => Services.Get<MapaService>();
        private ILoteService LoteService => Services.Get<LoteService>();
        private IEstruturaMercadologicaService EstruturaService => Services.Get<EstruturaMercadologicaService>();
        private ILogService LogService => Services.Get<LogService>();

        private const string registroExcedente = "Registro excedente";

        public CarrinhoService() : base() { }

        public CarrinhoService(DataContext dbContext) : base(dbContext) { }

        [Obsolete]
        public int CriarCarrinhoSams(List<PesquisaPrateleiraResultado> itens, string login, bool somenteGrid, string codSistema)
        {
            //List<MapaData> mapa = MapaService.MapaCarrinhoItem();
            //List<string> updateSet = new List<string>();
            //mapa.ForEach(m => updateSet.Add($"[{m.CampoCarrinhoItem}] = {m.EntidadeOrigem}.[{m.CampoOrigem}]{Environment.NewLine}"));
            //string scriptCriarCarrinho = string.Format(CarrinhoScripts.CriarCarrinhoSams, string.Join(", ", updateSet.ToArray()));
            //string tipoProc = somenteGrid ? "G" : "P";
            //int idCarrinho = Repository.CriarCarrinhoSams(scriptCriarCarrinho, itens, login, tipoProc, codSistema);
            //AtualizarDescrEstrutura(idCarrinho);
            //return idCarrinho;
            throw new NotImplementedException();
        }

        public List<CarrinhoItemData> ItensCarrinhoDisponivel(int idCarrinho)
        {
            return Repository.ItensCarrinhoDisponivel(idCarrinho).ToObject<CarrinhoItemData>();
        }

        public FileInfo Exportar(int idCarrinho, string filePath)
        {
            List<MapaData> mapas = MapaService.MapaTemplate();
            List<string> select = new List<string>();
            mapas.ForEach(m =>
            {
                if (m.Tipo == 'N')
                {
                    select.Add(string.Format(
                    "Convert(Numeric({3}, {4}), Case When isnumeric({0}) = 1 Then {0} Else Null End) as [{1}]{2}",
                    string.IsNullOrEmpty(m.CampoCarrinhoItem) ? "''" : $"[{m.CampoCarrinhoItem}]",
                    m.NomeColuna,
                    Environment.NewLine,
                    m.Tamanho,
                    m.Precisao));
                }
                else
                {
                    select.Add(string.Format(
                        "{0} as [{1}]{2}",
                        string.IsNullOrEmpty(m.CampoCarrinhoItem) ? "''" : $"[{m.CampoCarrinhoItem}]",
                        m.NomeColuna,
                        Environment.NewLine));
                }
            });
            string scriptObterExportacao = string.Format(CarrinhoScripts.ObterExportacao, string.Join(", ", select.ToArray()));
            DataSet dsExportacao = Repository.ObterExportacao(scriptObterExportacao, idCarrinho);

            CarrinhoData carrinho = dsExportacao.Tables[0].ToObject<CarrinhoData>().FirstOrDefault();
            string outputName = carrinho != null ? string.Format("Template_{0}_{1}.xlsx", carrinho.Login, carrinho.IdCarrinho) : string.Format("Template_Novos_Produtos_{0:yyyyMMdd}_{0:HHmmss}.xlsx", DateTime.Now);
            FileInfo outputFile = new FileInfo(Path.Combine(filePath, outputName));
            if (outputFile.Exists)
            {
                outputFile.Delete();
            }

            dsExportacao.Tables[1].TableName = "Itens";

            // Mapeamento de colunas dos grupos.
            List<string> grupos = mapas.Where(m => !string.IsNullOrEmpty(m.Grupo)).Select(g => g.Grupo).Distinct().ToList();
            List<Tuple<int, int>> colsGrupos = new List<Tuple<int, int>>();
            grupos.ForEach(
                g =>
                    {
                        IEnumerable<MapaData> grupo = mapas.Where(m => m.Grupo == g);
                        colsGrupos.Add(new Tuple<int, int>(grupo.Min(m => m.Ordem).Value, grupo.Max(m => m.Ordem).Value));
                    });

            // Converte campos numericos en-us para pt-br.
            //List<MapaData> mapasNumericos = mapas.Where(m => m.Tipo == 'N' && m.PodeAlterar).ToList();
            //dsExportacao.Tables[1].Rows.ForEach(r => mapasNumericos.ForEach(m => r[m.NomeColuna] = (r[m.NomeColuna] ?? string.Empty).ToString().Replace(".", ",")));

            using (XLWorkbook wb = new XLWorkbook())
            {
                IXLWorksheet ws = wb.Worksheets.Add(dsExportacao.Tables[1]);

                mapas.Where(m => !string.IsNullOrEmpty(m.Descricao)).ToList().ForEach(m =>
                {
                    string[] descricao = m.Descricao.Split(';');
                    for (int i = 0; i < descricao.Length; i++)
                    {
                        if (i > 0)
                        {
                            ws.Cell(1, m.Ordem.Value).Comment.AddNewLine();
                        }
                        
                        ws.Cell(1, m.Ordem.Value).Comment.AddText(descricao[i]);
                    }
                    
                    ws.Cell(1, m.Ordem.Value).Comment.Style.Size.SetAutomaticSize(true);
                });

                ws.Columns().AdjustToContents(1, 1);

                if (colsGrupos.Count > 0) // Agrupamento de colunas.
                {
                    ws.Outline.SummaryHLocation = XLOutlineSummaryHLocation.Left;
                    colsGrupos.ForEach(cg => ws.Columns(cg.Item1, cg.Item2).Group());
                    ws.CollapseColumns();
                }

                wb.SaveAs(outputFile.FullName);
            }

            ExcluirOutputFile(1, outputFile);

            return outputFile;
        }

        public FileInfo Exportar(string filePath)
        {
            return Exportar(-1, filePath);
        }

        private void ExcluirOutputFile(int delay, FileInfo outputFile)
        {
            // Deixa uma task para que o arquivo criado seja excluído em x minutos.
            Action<FileInfo> deleteFile = async (fileInfo) =>
            {
                await Task.Delay(TimeSpan.FromMinutes(delay));
                try
                {
                    if (File.Exists(fileInfo.FullName))
                    {
                        File.Delete(fileInfo.FullName);
                    }
                }
                catch { }
            };
            Task.Run(() => deleteFile(outputFile));
        }

        public ImportResult Importar(Stream inputFile, string login, string filePath, string codSistema)
        {
            return Importar(inputFile, -1, login, filePath, codSistema);
        }

        public ImportResult Importar(Stream inputFile, int idCarrinho, string login, string filePath, string codSistema)
        {
            bool novosProdutos = idCarrinho <= 0;

            List<List<object>> values = new List<List<object>>();
            List<CarrinhoItemData> itensCarrinho = ItensCarrinhoDisponivel(idCarrinho);
            bool excedente, conteudoValido;
            ImportResult result = new ImportResult { AlertType = "alert-warning", AlertMsg = string.Empty, OutputFile = null, PodeEnviar = false };

            // Mapas
            List<MapaData> mapas = MapaService.MapaTemplate();
            List<MapaData> mapasAlteracao = mapas.Where(m => m.PodeAlterar).ToList();
            List<MapaData> mapasNumericos = mapas.Where(m => m.Tipo == 'N' && m.PodeAlterar).ToList();
            List<MapaData> mapasAlfaNumericos = mapas.Where(m => m.Tipo == 'A' && m.PodeAlterar).ToList();
            int indexIdCarrinhoItem = Importar_GetIndex<CarrinhoItemData, int>(c => c.IdCarrinhoItem, mapas);
            int indexProdutoNbr = Importar_GetIndex<CarrinhoItemData, string>(c => c.produto_nbr, mapas);
            int indexValidacaoTemplate = Importar_GetIndex<CarrinhoItemData, string>(c => c.ValidacaoTemplate, mapas);

            try
            {
                values = Importar_LerArquivo(inputFile);
            }
            catch (Exception)
            {
                result.AlertMsg = "O conteúdo do arquivo é inválido.";
                return result;
            }

            if (!Importar_ValidarColunas(values, mapas))
            {
                result.AlertMsg = "As colunas esperadas não foram localizadas no arquivo.";
                return result;
            }


            if (novosProdutos)
            {
                excedente = false;
            }
            else
            {
                try
                {
                    excedente = Importar_ValidarChaves(values, mapas, itensCarrinho, indexIdCarrinhoItem, indexProdutoNbr, indexValidacaoTemplate);
                }
                catch (Exception)
                {
                    result.AlertMsg = "Os registros no arquivo não correspondem ao carrinho.";
                    return result;
                }
            }

            conteudoValido = Importar_ValidarConteudo(idCarrinho, values, mapasAlteracao, indexValidacaoTemplate, indexIdCarrinhoItem, out List<CarrinhoItemData> validacaoTeplateValues);
            if (!conteudoValido || excedente)
            {
                result.OutputFile = Importar_CriarArquivoRetorno(inputFile, login, idCarrinho, filePath, values, mapas, indexValidacaoTemplate);
            }

            // Executar atualização
            try
            {
                string guid = Guid.NewGuid().ToString("N");
                if (conteudoValido)
                {
                    List<string> updateSet = new List<string>();
                    mapasAlteracao.ForEach(m => updateSet.Add($"ci.[{m.CampoCarrinhoItem}] = b.[{m.CampoCarrinhoItem}]{Environment.NewLine}"));
                    string scriptAtualizacao = string.Format(CarrinhoScripts.AtualizarCarrinho, string.Join(", ", updateSet.ToArray()));
                    DataTable tblBulk = Importar_ObterBulkAtualizacao(values, mapasNumericos, mapasAlfaNumericos, mapasAlteracao, indexIdCarrinhoItem, indexValidacaoTemplate, idCarrinho, guid);

                    if (novosProdutos)
                    {
                        idCarrinho = Repository.CriarCarrinhoNovo(login, guid, tblBulk, codSistema);
                    }
                    else
                    {
                        Repository.AtualizarCarrinho(scriptAtualizacao, tblBulk, idCarrinho, guid);
                    }

                    AtualizarDescrEstrutura(idCarrinho);

                    result.IdCarrinho = idCarrinho;
                    result.AlertType = "alert-success";
                    result.AlertMsg = result.OutputFile == null ?
                        "Importação realizada com sucesso!" :
                        $"Importação realizada com ressalvas, os detalhes estão no arquivo {result.OutputFile.Name} gerado.";
                    result.PodeEnviar = true;
                    return result;
                }
                else
                {
                    if (!novosProdutos)
                    {
                        DataTable tblBulk = Importar_ObterBulkValidacao(validacaoTeplateValues, guid, idCarrinho);
                        Repository.AtualizarCarrinho(CarrinhoScripts.AtualizarValidacaoTemplate, tblBulk, idCarrinho, guid);
                    }

                    result.AlertMsg = $"Um ou mais registros no arquivo possuem erros, os detalhes estão no arquivo {result.OutputFile.Name} gerado.";
                    return result;
                }
            }
            catch (Exception ex)
            {
                result.AlertType = "alert-danger";
                result.AlertMsg = $"Erro de definição de dados, entre em contato com o suporte técnico: {ex.Message}";
                result.OutputFile = null;
                return result;
            }
        }

        /// <summary>
        /// Converte o Stream Xlsx em uma matriz bidimensional (linhas x colunas) de objetos.
        /// Espera-se que a linha 0 contenha nomes de colunas.
        /// </summary>
        /// <param name="inputFile">Stream Xlsx</param>
        /// <returns>
        /// Matriz bidimensional de objetos (linhas e colunas).
        /// Possível emissão de erros.
        /// </returns>
        private List<List<object>> Importar_LerArquivo(Stream inputFile)
        {
            List<List<object>> values = new List<List<object>>();
            using (XLWorkbook wb = new XLWorkbook(inputFile))
            {
                IXLWorksheet ws = wb.Worksheet(1);
                int columnCount = ws.ColumnsUsed().Count();
                int rowCount = ws.RowsUsed().Count();
                for (int row = 1; row <= rowCount; row++)
                {
                    List<object> rowValues = new List<object>();
                    for (int col = 1; col <= columnCount; col++)
                    {
                        rowValues.Add(ws.Cell(row, col).Value);
                    }

                    values.Add(rowValues);
                }
            }

            return values;
        }

        /// <summary>
        /// Validação da estrutura de colunas (nome e ordem).
        /// </summary>
        /// <param name="values">Matriz de dados importados.</param>
        /// <param name="mapas">Mapa de dados.</param>
        /// <returns>Indicador de validação.</returns>
        private bool Importar_ValidarColunas(List<List<object>> values, List<MapaData> mapas)
        {
            foreach (MapaData m in mapas)
            {
                if (!values[0].Contains(m.NomeColuna) || values[0].IndexOf(m.NomeColuna) + 1 != m.Ordem)
                {
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// Validação de chave dupla (IdCarrinhoItem e item_nbr).
        /// Registra alerta de registro excedente na matriz de importação para retorno.
        /// </summary>
        /// <param name="values">Matriz de dados importados.</param>
        /// <param name="mapas">Mapa de dados.</param>
        /// <param name="itensCarrinho">Itens em edição no carrinho.</param>
        /// <param name="indexIdCarrinhoItem">Indice de coluna.</param>
        /// <param name="indexProdutoNbr">Indice de coluna.</param>
        /// <param name="indexValidacaoTemplate">Indice de coluna.</param>
        /// <returns>
        /// Indicador de registros excedentes nos dados importados.
        /// Emite erro para chaves faltantes ou duplicadas.
        /// </returns>
        private bool Importar_ValidarChaves(List<List<object>> values, List<MapaData> mapas, List<CarrinhoItemData> itensCarrinho, int indexIdCarrinhoItem, int indexProdutoNbr, int indexValidacaoTemplate)
        {
            // Verifica se existe somente um registro para cada chave.
            foreach (CarrinhoItemData item in itensCarrinho)
            {
                int qtdChaves = values.Skip(1).Where(row =>
                    int.Parse(row[indexIdCarrinhoItem].ToString()) == item.IdCarrinhoItem &&
                    (
                        !string.IsNullOrEmpty(item.produto_nbr) && item.OrigemSad && row[indexProdutoNbr].ToString() == item.produto_nbr
                    )).Count();

                if (qtdChaves != 1)
                {
                    throw new Exception();
                }
            }

            // Verifica se existem chaves excedentes na planilha.
            bool excedente = false;
            foreach (List<object> row in values.Skip(1))
            {
                if (!itensCarrinho.Any(i =>
                    i.IdCarrinhoItem == int.Parse(row[indexIdCarrinhoItem].ToString()) &&
                    (
                        !string.IsNullOrEmpty(i.produto_nbr) && i.OrigemSad && row[indexProdutoNbr].ToString() == i.produto_nbr
                    )))
                {
                    excedente = true;
                    row[indexValidacaoTemplate] = registroExcedente;
                }
            }

            return excedente;
        }

        /// <summary>
        /// Retorna um indice de coluna com base zero para uma coluna especificada.
        /// </summary>
        /// <typeparam name="TClass">Definição da classe de origem da coluna especificada</typeparam>
        /// <typeparam name="TProperty">Definição da propriedade da coluna especificada.</typeparam>
        /// <param name="expression">Expressão para indicação da coluna desejada na classe especificada.</param>
        /// <param name="mapas">Mapa de dados.</param>
        /// <returns>Indice base zero da coluna especificada de acordo com o mapa de dados.</returns>
        private int Importar_GetIndex<TClass, TProperty>(Expression<Func<TClass, TProperty>> expression, List<MapaData> mapas)
        {
            string campo = ((MemberExpression)expression.Body).Member.Name;
            MapaData mapa = mapas.Single(m => m.CampoCarrinhoItem == campo);
            return mapa.Ordem.Value - 1;
        }

        /// <summary>
        /// Valida os dados na matriz de importação.
        /// Verifica obrigatoriedade, tamanho de campo, inteiros e decimais (pt-br).
        /// Verifica duplicidade de filiais.
        /// Não valida registros excedentes (considerados erro).
        /// Registra os detalhes de todos os erros localizados na matriz de importação para retorno.
        /// Registra os detalhes de todos os erros na tabela de CarrinhoItem.
        /// </summary>
        /// <param name="idCarrinho">Identificação do carrinho.</param>
        /// <param name="values">Matriz de importação.</param>
        /// <param name="mapasAlteracao">Mapa de dados.</param>
        /// <param name="indexValidacaoTemplate">Indice de coluna.</param>
        /// <param name="indexIdCarrinhoItem">Indice de coluna.</param>
        /// <param name="validacaoTemplateValues">Retorna a validação de cada registro.</param>
        /// <returns>Indicador de conteúdo válido.</returns>
        private bool Importar_ValidarConteudo(int idCarrinho, List<List<object>> values, List<MapaData> mapasAlteracao, int indexValidacaoTemplate, int indexIdCarrinhoItem, out List<CarrinhoItemData> validacaoTemplateValues)
        {
            bool conteudoValido = true;
            validacaoTemplateValues = new List<CarrinhoItemData>();
            int rowIndex = 0;
            foreach (List<object> row in values.Skip(1))
            {
                rowIndex++;
                int idCarrinhoItem = idCarrinho <= 0 ? rowIndex : int.Parse(row[indexIdCarrinhoItem].ToString());

                if (row[indexValidacaoTemplate].ToString() == registroExcedente)
                {
                    continue;
                }

                List<string> erros = new List<string>();
                List<string> filpfl = new List<string>();
                foreach (MapaData mapa in mapasAlteracao)
                {
                    object valor = row[mapa.Ordem.Value - 1] ?? string.Empty;
                    if (mapa.Obrigatorio && string.IsNullOrWhiteSpace(valor.ToString()))
                    {
                        erros.Add($"Campo {mapa.NomeColuna} obrigatório");
                    }

                    if (mapa.Tipo == 'A' && valor.ToString().Length > mapa.Tamanho.Value)
                    {
                        erros.Add($"Campo {mapa.NomeColuna} excede o limite de {mapa.Tamanho.Value} caracteres");
                    }

                    if (mapa.Tipo != 'A' && valor.ToString().Length > 0)
                    {
                        int d = mapa.Precisao.Value;
                        int i = mapa.Tamanho.Value - d;
                        if (!Regex.IsMatch(valor.ToString().Replace(".", ","), d > 0 ? $@"^(\d{{1,{i}}}|\d{{1,{i}}},\d{{1,{d}}})$" : $@"^(\d{{1,{i}}})$"))
                        {
                            erros.Add($"Campo {mapa.NomeColuna} não é um número válido ({mapa.Tamanho.Value.ToString()},{mapa.Precisao.ToString()}).");
                        }
                    }

                    // Filiais duplicadas.
                    if (mapa.CampoCarrinhoItem.StartsWith("Filpfl_") && !string.IsNullOrWhiteSpace(valor.ToString()))
                    {
                        if (filpfl.Contains(valor.ToString()))
                        {
                            erros.Add($"Campo {mapa.NomeColuna} está em duplicidade com outra filial");
                        }

                        filpfl.Add(valor.ToString());
                    }
                }

                string validacaoTemplate = string.Empty;
                if (erros.Count > 0)
                {
                    conteudoValido = false;
                    validacaoTemplate = string.Join(". ", erros.ToArray());
                    row[indexValidacaoTemplate] = validacaoTemplate;
                }

                validacaoTemplateValues.Add(new CarrinhoItemData { IdCarrinhoItem = idCarrinhoItem, ValidacaoTemplate = validacaoTemplate });
                //Repository.AtualizarValidacaoTemplate(idCarrinhoItem, validacaoTemplate);
            }

            return conteudoValido;
        }

        /// <summary>
        /// Cria um arquivo de retorno com base na matriz de importação original acrescida do resultado das validação.
        /// Exclui o arquivo criado após 10 minutos.
        /// </summary>
        /// <param name="inputFile">Matriz de importação original.</param>
        /// <param name="login">Usuário.</param>
        /// <param name="idCarrinho">Carrinho atual.</param>
        /// <param name="filePath">Endereço físico de geração do arquivo.</param>
        /// <param name="values">Matriz de importação com detalhes de alertas e erros.</param>
        /// <param name="mapas">Mapa de dados.</param>
        /// <param name="indexValidacaoTemplate">Indice de coluna.</param>
        /// <returns>Informações do arquivo para retorno ao usuário.</returns>
        private FileInfo Importar_CriarArquivoRetorno(Stream inputFile, string login, int idCarrinho, string filePath, List<List<object>> values, List<MapaData> mapas, int indexValidacaoTemplate)
        {
            string outputName = idCarrinho > 0 ? string.Format("Template_{0}_{1}.xlsx", login, idCarrinho) : string.Format("Template_Novos_Produtos_{0:yyyyMMdd}_{0:HHmmss}.xlsx", DateTime.Now);
            FileInfo outputFile = new FileInfo(Path.Combine(filePath, outputName));
            if (outputFile.Exists)
            {
                outputFile.Delete();
            }

            using (XLWorkbook wb = new XLWorkbook(inputFile))
            {
                IXLWorksheet ws = wb.Worksheet(1);
                int columnCount = ws.ColumnsUsed().Count();
                int rowCount = ws.RowsUsed().Count();
                for (int row = 2; row <= rowCount; row++)
                {
                    ws.Cell(row, indexValidacaoTemplate + 1).SetValue(values[row - 1][indexValidacaoTemplate]);
                }

                wb.SaveAs(outputFile.FullName);
            }

            ExcluirOutputFile(10, outputFile);
            return outputFile;
        }

        private DataTable Importar_ObterBulkValidacao(List<CarrinhoItemData> validacaoTemplateValues, string guid, int idCarrinho)
        {
            DataTable tblBulk = Repository.ObterCarrinhoItemBulk();
            foreach (CarrinhoItemData item in validacaoTemplateValues)
            {
                DataRow row = tblBulk.NewRow();
                row["Guid"] = guid;
                row["IdCarrinho"] = idCarrinho;
                row["IdCarrinhoItem"] = item.IdCarrinhoItem;
                row["ValidacaoTemplate"] = string.IsNullOrEmpty(item.ValidacaoTemplate) ? DBNull.Value : item.ValidacaoTemplate as object;
                tblBulk.Rows.Add(row);
            }
            return tblBulk;
        }

        /// <summary>
        /// Montagem dinâmica de tabela bulk para atualização do carrinho.
        /// Converte números pt-br em en-us.
        /// </summary>
        /// <param name="values">Matriz de importação.</param>
        /// <param name="mapasNumericos">Mapa de campos numéricos.</param>
        /// <param name="mapasAlfaNumericos">Mapa de campos alfa-numéricos.</param>
        /// <param name="mapasAlteracao">Mapa de campos atualizaveis.</param>
        /// <param name="indexIdCarrinhoItem">Indice de coluna.</param>
        /// <param name="indexValidacaoTemplate">Indice de coluna.</param>
        /// <param name="idCarrinho">Identificação do carrinho.</param>
        /// <param name="guid">Identificador exclusivo da operação.</param>
        /// <returns>DataTable para bulk insert.</returns>
        private DataTable Importar_ObterBulkAtualizacao(List<List<object>> values, List<MapaData> mapasNumericos, List<MapaData> mapasAlfaNumericos, List<MapaData> mapasAlteracao, int indexIdCarrinhoItem, int indexValidacaoTemplate, int idCarrinho, string guid)
        {
            DataTable tblBulk = Repository.ObterCarrinhoItemBulk();
            int rowId = 0;
            foreach (List<object> row in values.Skip(1))
            {
                if (row[indexValidacaoTemplate].ToString() == registroExcedente)
                {
                    continue;
                }

                // Converte campos numericos pt-br para en-us.
                mapasNumericos.ForEach(m => row[m.Ordem.Value - 1] = (row[m.Ordem.Value - 1] ?? string.Empty).ToString().Replace(",", "."));
                // Converte campos alfanumerico para texto.
                mapasAlfaNumericos.ForEach(m => row[m.Ordem.Value - 1] = (row[m.Ordem.Value - 1] ?? string.Empty).ToString());

                DataRow bulkRow = tblBulk.NewRow();

                bulkRow["Guid"] = guid;
                bulkRow["IdCarrinho"] = idCarrinho;
                rowId++;
                bulkRow["IdCarrinhoItem"] = idCarrinho <= 0 ? rowId : Convert.ToInt32(row[indexIdCarrinhoItem]);

                mapasAlteracao.ForEach(m => bulkRow[m.CampoCarrinhoItem] = row[m.Ordem.Value - 1]);

                tblBulk.Rows.Add(bulkRow);
            }

            return tblBulk;
        }

        public IDictionary<int, string> CarrinhosDisponiveis(string login, string codOrigem, string codSistema)
        {
            return Repository.CarrinhosDisponiveis(login, codOrigem, codSistema).ToDictionary<int, string>();
        }

        public string Enviar(int idCarrinho)
        {
            string jSon, numeroLote;

            LoteData lote = LoteService.UltimoLote(idCarrinho);
            if (lote != null && !lote.DhRetorno.HasValue)
            {
                throw new Exception(string.Format("Este carrinho foi enviado previamente em {0:dd/MM/yy} às {0:hh:mm:ss} e ainda não obteve retorno.", lote.DhEnvio));
            }

            try
            {
                jSon = Enviar_ObterJSon(idCarrinho);
            }
            catch (Exception ex)
            {
                LogService.Erro("CarrinhoService.Enviar_ObterJSon", ex);
                throw new Exception($"Houve um erro na conversão do carrinho para envio ao SAD: {ex.Message}");
            }

            try
            {
                string codSistema = Repository.ObterCarrinho(idCarrinho).Read<string>("CodSistema");
                numeroLote = SadService.IncluirSolicitacao(jSon, codSistema);
            }
            catch (Exception ex)
            {
                LogService.Erro("SadService.IncluirSolicitacao", ex);
                throw new Exception($"Houve um erro na comunicação com o SAD {ex.Message}");
            }

            if (!LoteService.Incluir(idCarrinho, numeroLote))
            {
                throw new Exception("O número de lote obtido junto ao SAD já foi utilizado.");
            }

            return numeroLote;
        }

        private string Enviar_ObterJSon(int idCarrinho)
        {
            string blocoGrupo = "{";
            string fechamentoGrupoParcial = "},";
            string fechamentoGrupoFinal = "}";
            string campoChaveCarrinhoItem = "IdCarrinhoItem";
            string formatJSon = "{{ \"idOrigem\": \"CARGASAMS\", \"mensagem\": [ {0} ] }}";

            CarrinhoData carrinho = Repository.ObterCarrinho(idCarrinho).ToObject<CarrinhoData>().FirstOrDefault();
            if (carrinho is null)
            {
                throw new Exception("Carrinho inexistente.");
            }

            DataTable carrinhoItens = Repository.ObterCarrinhoItemEnvio(idCarrinho);
            if (!carrinhoItens.HasRows())
            {
                throw new Exception("O arquivo selecionado não possui dados.");
            }

            List<MapaData> mapas = MapaService.MapaJSon();

            StringBuilder mensagens = new StringBuilder();

            int ultimoIdCarrinhoItem = carrinhoItens.Rows[carrinhoItens.Rows.Count - 1].Read<int>(campoChaveCarrinhoItem);

            foreach (DataRow carrinhoItem in carrinhoItens.Rows)
            {
                StringBuilder camposJSon = Enviar_ObterMensagem(carrinhoItem, mapas, blocoGrupo, fechamentoGrupoParcial, fechamentoGrupoFinal);

                mensagens.Append(blocoGrupo);
                mensagens.Append(camposJSon.ToString());
                mensagens.Append(carrinhoItem.Read<int>(campoChaveCarrinhoItem) != ultimoIdCarrinhoItem ? fechamentoGrupoParcial : fechamentoGrupoFinal);
            }

            return string.Format(formatJSon, mensagens.ToString());
        }

        private StringBuilder Enviar_ObterMensagem(DataRow carrinhoItem, List<MapaData> mapas, string blocoGrupo, string fechamentoGrupoParcial, string fechamentoGrupoFinal)
        {
            string grupoJSonRoot = "Root";
            string grupoJSonFilial = "FILIAL";
            string campoChaveFilial = "Filpfl";
            string formatCampoJSon = "\"{0}\": {1},";
            string formatCampoJSonFinal = "\"{0}\": {1}";
            //string formatCampoJSon = "\"{0}\": \"{1}\",";
            //string formatCampoJSonFinal = "\"{0}\": \"{1}\"";
            string formatGrupo = "\"{0}\": {{";
            string fechamentoGrupo = "},";
            string blocoJSonFilial = "\"FILIAIS\": { \"detFil\": [ ";
            string fechamentoJSonFilial = "] }";

            JavaScriptSerializer serializer = new JavaScriptSerializer();

            StringBuilder camposJSon = new StringBuilder();

            // Grupo Root
            List<MapaData> mapasRoot = mapas.Where(m => m.GrupoJSon == grupoJSonRoot).ToList();
            mapasRoot.ForEach(m => camposJSon.AppendFormat(formatCampoJSon, m.CampoJSon, serializer.Serialize(carrinhoItem.Read<string>(m.CampoCarrinhoItem))));

            // Grupos Comuns
            List<string> grupos = mapas
                .Where(m => m.GrupoJSon != grupoJSonRoot && !m.GrupoJSon.StartsWith(grupoJSonFilial))
                .OrderBy(o => o.OrdemJSon)
                .Select(m => m.GrupoJSon)
                .Distinct()
                .ToList();
            foreach (string grupo in grupos)
            {
                camposJSon.AppendFormat(formatGrupo, grupo);
                List<MapaData> mapasGrupo = mapas.Where(m => m.GrupoJSon == grupo).ToList();
                int ordemUltimoCampo = mapasGrupo.Max(m => m.OrdemJSon).Value;
                mapasGrupo.ForEach(m => camposJSon.AppendFormat(
                    m.OrdemJSon == ordemUltimoCampo ? formatCampoJSonFinal : formatCampoJSon,
                    m.CampoJSon,
                    serializer.Serialize(carrinhoItem.Read<string>(m.CampoCarrinhoItem))));
                camposJSon.Append(fechamentoGrupo);
            }

            // Grupos de filial
            /*
             * Cada filial é um conjunto de colunas.
             * Esse conjunto é agrupado em um dicionario.
             * Esses dicionarios são agrupados em uma lista para ordenação.
             */

            // Lista de dicionários.
            List<Dictionary<string, string>> filiais = new List<Dictionary<string, string>>();

            // Relação de grupos de filiais
            List<string> gruposFilial = mapas
                .Where(m => m.GrupoJSon.StartsWith(grupoJSonFilial))
                .OrderBy(o => o.OrdemJSon)
                .Select(m => m.GrupoJSon)
                .Distinct()
                .ToList();

            // Agrupamento de colunas de filial em dicionários e agrupamento dos dicionários em lista.
            foreach (string grupo in gruposFilial)
            {
                Dictionary<string, string> filial = new Dictionary<string, string>();
                List<MapaData> mapasGrupo = mapas.Where(m => m.GrupoJSon == grupo).ToList();
                mapasGrupo.ForEach(m => filial[m.CampoJSon] = carrinhoItem.Read<string>(m.CampoCarrinhoItem));
                filiais.Add(filial);
            }

            // Eliminação de finiais vazias e ordenação das filiais.
            filiais = filiais
                .Where(f => !string.IsNullOrWhiteSpace(f[campoChaveFilial]) && int.TryParse(f[campoChaveFilial], out int chaveFilial))
                .OrderBy(f => int.Parse(f[campoChaveFilial]))
                .ToList();

            // Escrita do JSon de filiais.
            camposJSon.Append(blocoJSonFilial);
            int currFilial = 0;

            foreach (Dictionary<string, string> filial in filiais)
            {
                camposJSon.Append(blocoGrupo);
                foreach (KeyValuePair<string, string> campo in filial)
                {
                    camposJSon.AppendFormat(
                        campo.Key == filial.Last().Key ? formatCampoJSonFinal : formatCampoJSon,
                        campo.Key,
                        serializer.Serialize(campo.Value));
                }
                camposJSon.Append(++currFilial == filiais.Count ? fechamentoGrupoFinal : fechamentoGrupoParcial);
            }

            camposJSon.Append(fechamentoJSonFilial);

            return camposJSon;
        }

        public void AtualizarDescrEstrutura(int idCarrinho)
        {
            Repository.AtualizarDescrEstrutura(idCarrinho);
        }

        public void RemoverCarrinhoItens(List<int> idsCarrinhoItem, string login)
        {
            Repository.RemoverCarrinhoItens(idsCarrinhoItem, login);
        }

        public void RemoverCarrinhoItem(int idCarrinhoItem, string login)
        {
            List<int> idsCarrinhoItem = new List<int> { idCarrinhoItem };
            RemoverCarrinhoItens(idsCarrinhoItem, login);
        }

        public ContagemCardHome ObterContagemCardHome()
        {
            return Repository.ObterContagemCardHome().ToObject<ContagemCardHome>().FirstOrDefault();
        }

        
        public FileInfo DownloadCardCross(string filePath)
        {
            return DownloadCard(Repository.DownloadCardCross(), "ItensSemCross", filePath);
        }
        public FileInfo DownloadCardComCross(string filePath)
        {
            return DownloadCard(Repository.DownloadCardComCross(), "ItensComCross", filePath);
        }

        public FileInfo DownloadCardErroRetorno(string filePath)
        {
            return DownloadCard(Repository.DownloadCardErroRetorno(), "ErroProcessamentoSad", filePath);
        }

        public FileInfo DownloadCardCarrinho(string filePath)
        {
            return DownloadCard(Repository.DownloadCardECarrinho(), "GestaoCarrinhoItemCritica", filePath);
        }

        private FileInfo DownloadCard(DataTable dataTable, string nome, string filePath)
        {
            string outputName = string.Format("{0}_{1:ddMMyyHHmmss}.xlsx", nome, DateTime.Now);
            FileInfo outputFile = new FileInfo(Path.Combine(filePath, outputName));
            if (outputFile.Exists)
            {
                outputFile.Delete();
            }

            dataTable.TableName = nome;

            using (XLWorkbook wb = new XLWorkbook())
            {
                IXLWorksheet ws = wb.Worksheets.Add(dataTable);
                ws.Columns().AdjustToContents(1, 1);
                wb.SaveAs(outputFile.FullName);
            }

            ExcluirOutputFile(5, outputFile);
            return outputFile;
        }

        public List<GestaoCarrinhoItens> PesquisaGestaoCarrinho(GestaoCarrinhoFiltro filtro)
        {
            return Repository.PesquisaGestaoCarrinho(filtro.ToJSon()).ToObject<GestaoCarrinhoItens>();
        }

        public List<ProdutoData> PesquisarProdutos(List<long> itens, int secao, int linha, int sublinha, string codSistema)
        {
            try
            {
                string pesquisaJSon = new PesquisaProdutoData(itens, secao, linha, sublinha).ToJSon();
                string lote = SadService.BuscaProdutos(pesquisaJSon, codSistema);
                bool loteProcessado = false;
                do
                {
                    Thread.Sleep(new TimeSpan(0, 0, 2));
                    loteProcessado = SadService.BuscarProdutosLote(lote, codSistema);
                } while (!loteProcessado);

                List<ProdutoData> produtos = SadService.BuscarProdutosLoteDetalhe(lote, codSistema);

                List<EstruturaMercadologicaSadData> estruturas = EstruturaService.ObterEstruturaSad(codSistema);
                produtos.ForEach(p =>
                {
                    EstruturaMercadologicaSadData estrutura = estruturas.SingleOrDefault(e =>
                        e.Secao == int.Parse(p.Basico.Secao) && e.Linha == int.Parse(p.Basico.Linha) && e.Sublinha == int.Parse(p.Basico.Slinha));
                    if (estrutura != null)
                    {
                        p.Basico.SecaoDesc = estrutura.SecaoDesc;
                        p.Basico.LinhaDesc = estrutura.LinhaDesc;
                        p.Basico.SlinhaDesc = estrutura.SubinhaDesc;
                    }
                });

                return produtos;

            }
            catch (Exception ex)
            {
                LogService.Erro("CarrinhoService.PesquisarProdutos", ex);
                throw;
            }
        }

        public int CriarCarrinhoSad(List<ProdutoData> produtos, AppUserData user, bool somenteGrid, string codSistema)
        {
            if (produtos.Count == 0)
            {
                throw new Exception("Nenhum produto informado!");
            }

            int idCarrinho = Repository.CriarCarrinhoSad(user.Login, codSistema);

            void add(List<DataParam> ps, MapaData mapa, Dictionary<string, object> dic)
            {
                if (dic.ContainsKey(mapa.CampoJSon))
                {
                    string valor = dic[mapa.CampoJSon].ToString();
                    ps.Add(DataParam.Create(mapa.CampoCarrinhoItem, string.IsNullOrWhiteSpace(valor) ? string.Empty : valor.Length > mapa.Tamanho.Value ? valor.Substring(0, mapa.Tamanho.Value) : valor));
                }
            };

            List<string> camposIgnorados = new List<string> { "idRegistro", "Matric" };

            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
            List<MapaData> mapas = MapaService.MapaJSon();

            foreach (ProdutoData produto in produtos)
            {
                Dictionary<string, object> produtoDic = jsSerializer.Deserialize<Dictionary<string, object>>(produto.ProdutoJSon);
                List<DataParam> ps = new List<DataParam>();

                // Campos extras.
                ps.Add(DataParam.Create("IdCarrinho", idCarrinho));
                ps.Add(DataParam.Create("EmEdicao", 1));
                ps.Add(DataParam.Create("Matric", user.LoginSad));
                ps.Add(DataParam.Create("DhSelecionado", DateTime.Now));

                foreach (MapaData mapa in mapas)
                {
                    // Campos grupo Root
                    if (mapa.GrupoJSon == "Root" && !camposIgnorados.Contains(mapa.CampoJSon))
                    {
                        if (produtoDic.ContainsKey("TipProc"))
                        {
                            produtoDic["TipProc"] = somenteGrid ? "G" : "P";
                        }

                        add(ps, mapa, produtoDic);
                    }

                    // Campos de grupos, exceto grupos de filial.
                    if (mapa.GrupoJSon != "Root" && !mapa.GrupoJSon.StartsWith("FILIAL"))
                    {
                        if (produtoDic.ContainsKey(mapa.GrupoJSon))
                        {
                            Dictionary<string, object> grupoDic = produtoDic[mapa.GrupoJSon] as Dictionary<string, object>;
                            add(ps, mapa, grupoDic);
                        }
                    }

                    // Filiais
                    if (mapa.GrupoJSon.StartsWith("FILIAL"))
                    {
                        int index = int.Parse(mapa.GrupoJSon.Substring(7));
                        if (produtoDic.ContainsKey("FILIAIS"))
                        {
                            Dictionary<string, object> filiaisDic = produtoDic["FILIAIS"] as Dictionary<string, object>;
                            if (filiaisDic.ContainsKey("detFil"))
                            {
                                ArrayList filiais = filiaisDic["detFil"] as ArrayList;
                                if (filiais.Count >= index)
                                {
                                    Dictionary<string, object> filialDic = filiais[index - 1] as Dictionary<string, object>;
                                    add(ps, mapa, filialDic);
                                }
                            }
                        }
                    }
                }

                // Montagem do script.
                string fieldNames = string.Join(",", ps.Select(p => p.Name.Substring(1)));
                string parameterNames = string.Join(",", ps.Select(p => p.Name));

                Repository.CriarCarrinhoItemSad(fieldNames, parameterNames, ps.ToArray());
            }

            return idCarrinho;
        }

        public int CriarCarrinhoDessinc(CarrinhoDessincSadInclusao parametros, string loginSad)
        {
            DataContext.BeginTransaction();

            try
            {
                int idCarrinho = Repository.CriarCarrinhoDessinc(parametros);
                string dessincJSon = new IncluirDessincSadData(parametros.Produtos, loginSad).ToJSon();
                string numeroLote = SadService.Dessinc(dessincJSon);
                if (!LoteService.Incluir(idCarrinho, numeroLote))
                {
                    throw new Exception("O número de lote obtido junto ao SAD já foi utilizado.");
                }

                DataContext.CommitTransaction();
                return idCarrinho;
            }
            catch (Exception ex)
            {
                DataContext.RollbackTransaction();
                LogService.Erro("CarrinhoService.CriarCarrinhoDessinc", ex);
                throw;
            }
        }

        public CarrinhoData ObterCarrinho(int idCarrinho)
        {
            return Repository.ObterCarrinho(idCarrinho).ToObject<CarrinhoData>().FirstOrDefault();
        }

        public void RemoverCarrinhoItemAutomatico(int diasLimiteCarrinho)
        {
            Repository.RemoverCarrinhoItemAutomatico(diasLimiteCarrinho);
        }
    }
}

