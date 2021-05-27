using Apcm.Service.Data;
using Apcm.Service.Log;
using Apcm.Service.Sad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Cross
{
    internal sealed class CrossService : DataService<CrossRepository>, ICrossService
    {
        private ILogService LogService => Services.Get<LogService>();

        public CrossService() : base() { }

        public CrossService(DataContext dbContext) : base(dbContext) { }

        public void RegistrarCross(LoteDetalheMensagem loteDetalheMensagem)
        {
            Repository.RegistrarCross(loteDetalheMensagem);
        }

        public List<CrossData> Localizar(int produtoNbr, out bool log)
        {
            DataTable tblCrossData = Repository.Localizar(produtoNbr);
            log = tblCrossData.HasRows() ? false : Repository.ExisteLog(produtoNbr);
            return tblCrossData.ToObject<CrossData>();
        }

        public bool DessincLocal(string login, List<CrossData> crosses)
        {
            DessincLocalData dessincLocal = new DessincLocalData
            {
                Login = login,
                Crosses = crosses.Select(c => c.IdCross).ToList()
            };

            bool result = Repository.DessincLocal(dessincLocal);

            if (result)
            {
                AtualizarDessincSadReport();
            }

            return result;
        }

        public List<DessincPesquisaData> PesquisaDessinc(int? produtoNbr, int? itemNbr)
        {
            return Repository.PesquisaDessinc(produtoNbr, itemNbr).ToObject<DessincPesquisaData>().OrderBy(o => o.Data).ToList();
        }

        public void AtualizarDessincSadReport()
        {
            try
            {
                Repository.AtualizarDessincSadReport();
            }
            catch (Exception ex)
            {
                LogService.Erro("CrossService.AtualizarDessincSadReport", ex);
            }
        }

        public void EnviarDessincSadReport()
        {
            try
            {
                List<DessincSadReportData> dessincSadReports = Repository.ObterDessincSadReport().ToObject<DessincSadReportData>();
                if (dessincSadReports.Count == 0)
                {
                    return;
                }

                DessincSadReportEnvioData envio = new DessincSadReportEnvioData();
                DessincSadReportLoteData lote = new DessincSadReportLoteData();
                lote.Ids = new List<int>();
                envio.idOrigem = "DESINCRCDM";
                envio.mensagem = new List<DessincSadReportEnvioMensagemData>();
                dessincSadReports.ForEach(d =>
                {
                    envio.mensagem.Add(new DessincSadReportEnvioMensagemData { idLote = d.NumeroLote, idRegistro = d.IdCarrinhoItem.ToString() });
                    lote.Ids.Add(d.IdDessincSadReport);
                });

                lote.NumeroLote = SadService.DessincSadReport(envio.ToJSon());
                Repository.RegistrarLoteDessincSadReport(lote);
            }
            catch (Exception ex)
            {
                LogService.Erro("CrossService.AtualizarDessincSadReport", ex);
            }
        }
    }


}
