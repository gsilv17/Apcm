using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Apcm.Service.Carrinho;
using Apcm.Service.Cross;
using Apcm.Service.Data;
using Apcm.Service.Log;
using Apcm.Service.Sad;
using ClosedXML.Excel;

namespace Apcm.Service.Lote
{
    internal sealed class LoteService : DataService<LoteRepository>, ILoteService
    {
        private ILogService LogService => Services.Get<LogService>();
        private ICarrinhoService CarrinhoService => Services.Get<CarrinhoService>();
        private ICrossService CrossService => Services.Get<CrossService>();

        public LoteService() : base() { }

        public LoteService(DataContext dbContext) : base(dbContext) { }

        public bool Incluir(int idCarrinho, string numeroLote)
        {
            return Repository.Incluir(idCarrinho, numeroLote) == 1;
        }

        public LoteData UltimoLote(int idCarrinho)
        {
            return Repository.UltimoLote(idCarrinho).ToObject<LoteData>().FirstOrDefault();
        }

        public void ProcessarLotes()
        {
            List<LoteData> lotesPendentes = Repository.LotesPendentes().ToObject<LoteData>();
            if (lotesPendentes.Count == 0)
            {
                return;
            }

            bool possuiErro = false;

            foreach (LoteData lotePendente in lotesPendentes)
            {
                if (LoteProcessado(lotePendente))
                {
                    LoteDetalhe loteDetalhe = ObterLoteDetalhe(lotePendente);
                    if (loteDetalhe != null && loteDetalhe.mensagem.Count() > 0)
                    {
                        if (lotePendente.Dessinc)
                        {
                            try
                            {
                                if (loteDetalhe.mensagem.Any(m => m.CodProd == 0))
                                {
                                    possuiErro = true;
                                }
                                else
                                {
                                    CarrinhoDessincRetorno dessincRetorno = ObterDessincRetorno(lotePendente, loteDetalhe);
                                    possuiErro = Repository.RegistrarCarrinhoDessinc(dessincRetorno);

                                    if (!possuiErro)
                                    {
                                        CrossService.AtualizarDessincSadReport();
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                possuiErro = true;
                                LogService.Erro("LoteService.ProcessarLotes.Dessinc", ex, "Falha ao registrar lote {0}.", lotePendente.NumeroLote);
                            }
                        }
                        else
                        {
                            foreach (LoteDetalheMensagem loteDetalheMensagem in loteDetalhe.mensagem)
                            {
                                DataContext.BeginTransaction();
                                try
                                {
                                    Repository.RegistrarCarrinhoItemLote(lotePendente.NumeroLote, loteDetalheMensagem);
                                    if (loteDetalheMensagem.CodRet == "000")
                                    {
                                        CarrinhoService.RemoverCarrinhoItem(loteDetalheMensagem.idRegistro, string.Empty);
                                        CrossService.RegistrarCross(loteDetalheMensagem);
                                    }

                                    DataContext.CommitTransaction();
                                }
                                catch (Exception ex)
                                {
                                    DataContext.RollbackTransaction();
                                    possuiErro = true;
                                    LogService.Erro(
                                        "LoteService.ProcessarLotes",
                                        ex,
                                        "Falha ao registrar lote {0} sob registro {1} retorno {2}.",
                                            lotePendente.NumeroLote,
                                            loteDetalheMensagem.idRegistro,
                                            loteDetalheMensagem.CodRet);
                                }
                            }
                        }

                        if (possuiErro)
                        {
                            Repository.RegistrarStatusRetornoErro("Um ou mais produtos no lote não foram processados.", lotePendente.NumeroLote);
                        }
                        else
                        {
                            Repository.ConfirmarLote(lotePendente.NumeroLote);
                        }
                    }
                }
            }

            //CrossService.EnviarDessincSadReport();
        }

        private CarrinhoDessincRetorno ObterDessincRetorno(LoteData lotePendente, LoteDetalhe loteDetalhe)
        {
            List<CarrinhoDessincRetornoDetalhe> produtos = new List<CarrinhoDessincRetornoDetalhe>();
            loteDetalhe.mensagem.ToList().ForEach(d => produtos.Add(new CarrinhoDessincRetornoDetalhe
            {
                ProdutoNbr = d.CodProd.ToString(),
                CodRetorno = d.CodRet,
                MsgRetorno = d.MsgRet
            }));

            return new CarrinhoDessincRetorno
            {
                NumeroLote = lotePendente.NumeroLote,
                Produtos = produtos
            };
        }

        private bool LoteProcessado(LoteData lotePendente)
        {
            try
            {
                bool loteProcessado = SadService.ConsultarLote(lotePendente);
                if (!loteProcessado)
                {
                    Repository.RegistrarStatusRetornoErro("Lote em processamento.", lotePendente.NumeroLote);
                }
                return loteProcessado;
            }
            catch (Exception ex)
            {
                Repository.RegistrarStatusRetornoErro(ex.Message, lotePendente.NumeroLote);
                LogService.Erro("LoteService.ConsultarLote", ex, "Lote {0}", lotePendente.NumeroLote);
                return false;
            }
        }

        private LoteDetalhe ObterLoteDetalhe(LoteData lotePendente)
        {
            try
            {
                LoteDetalhe loteDetalhe = SadService.ConsultarLoteDetalhe(lotePendente);
                if (loteDetalhe == null || loteDetalhe.mensagem == null || loteDetalhe.mensagem.Count() == 0)
                {
                    throw new Exception($"Lote {lotePendente.NumeroLote} possui processamento mas não possui detalhe.");
                }

                return loteDetalhe;
            }
            catch (Exception ex)
            {
                Repository.RegistrarStatusRetornoErro(ex.Message, lotePendente.NumeroLote);
                LogService.Erro("LoteService.ObterLoteDetalhe", ex, "Lote {0}", lotePendente.NumeroLote);
                return null;
            }
        }

        public Dictionary<string, string> ObterStatusItem(string codOrigem, DateTime? dataDe, DateTime? dataAte)
        {
            return Repository.ObterStatusItem(codOrigem, dataDe, dataAte).ToDictionary<string, string>();
        }

        public List<RetornoPesquisaLote> ConsultaLote(FiltroConsultaLote filtroPesquisaLote, out int qtdRegistros)
        {
            qtdRegistros = Repository.ContagemConsultaLote(filtroPesquisaLote);
            return Repository.ConsultaLote(filtroPesquisaLote).ToObject<RetornoPesquisaLote>();
        }

        public FileInfo ConsultaLoteExportacao(FiltroConsultaLote filtroPesquisaLote, string filePath)
        {
            string outputName = string.Format("PesquisaLote_{0:ddMMyyHHmmss}.xlsx", DateTime.Now);
            FileInfo outputFile = new FileInfo(Path.Combine(filePath, outputName));
            if (outputFile.Exists)
            {
                outputFile.Delete();
            }

            filtroPesquisaLote.StatusItemExport = "-02";
            DataTable tblSucesso = Repository.ConsultaLoteExportacao(filtroPesquisaLote);
            tblSucesso.TableName = "Sucesso";

            filtroPesquisaLote.StatusItemExport = "-03";
            DataTable tblErro = Repository.ConsultaLoteExportacao(filtroPesquisaLote);
            tblErro.TableName = "Falha";

            using (XLWorkbook wb = new XLWorkbook())
            {
                IXLWorksheet wsErro = wb.Worksheets.Add(tblErro);
                wsErro.Columns().AdjustToContents(1, 1);

                IXLWorksheet wsSucesso = wb.Worksheets.Add(tblSucesso);
                wsSucesso.Columns().AdjustToContents(1, 1);

                wb.SaveAs(outputFile.FullName);
            }

            ExcluirOutputFile(5, outputFile);
            return outputFile;
        }

        private void ExcluirOutputFile(int delay, FileInfo outputFile)
        {
            // Deixa uma task para que o arquivo criado seja excluído em x minutos.
            Action<FileInfo> deleteFile = async (fileInfo) =>
            {
                await Task.Delay(TimeSpan.FromMinutes(delay));
                try
                {
                    if (fileInfo.Exists)
                    {
                        fileInfo.Delete();
                    }
                }
                catch { }
            };
            Task.Run(() => deleteFile(outputFile));
        }
    }
}
