using Apcm.Service.Data;
using Apcm.Service.Sad;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Cross
{
    internal sealed class CrossRepository : DataRepository
    {
        public CrossRepository(DataContext dbContext) : base(dbContext) { }

        public void RegistrarCross(LoteDetalheMensagem loteDetalheMensagem)
        {
            DataContext.ExecuteNonQuery(
                CrossScripts.RegistrarCross,
                DataParam.Create("IdCarrinhoItem", loteDetalheMensagem.idRegistro),
                DataParam.Create("CodProd", loteDetalheMensagem.CodProd),
                DataParam.Create("Cean", loteDetalheMensagem.Cean),
                DataParam.Create("Tean", loteDetalheMensagem.Tean),
                DataParam.Create("Eandg", loteDetalheMensagem.Eandg));
        }

        public DataTable Localizar(int produtoNbr)
        {
            return DataContext.Load(CrossScripts.Localizar, DataParam.Create("ProdutoNbr", produtoNbr));
        }

        public bool ExisteLog(int produtoNbr)
        {
            return DataContext.ExecuteScalar<bool>(CrossScripts.ExisteLog, DataParam.Create("ProdutoNbr", produtoNbr));
        }

        public bool DessincLocal(DessincLocalData dessincLocal)
        {
            return DataContext.ExecuteScalar<bool>(CrossScripts.DessincLocal, DataParam.Create("DessincLocal", dessincLocal.ToJSon()));
        }

        public DataTable PesquisaDessinc(int? produtoNbr, int? itemNbr)
        {
            return DataContext.Load(CrossScripts.PesquisaDessinc, DataParam.Create("ProdutoNbr", produtoNbr), DataParam.Create("ItemNbr", itemNbr));
        }

        public void AtualizarDessincSadReport()
        {
            DataContext.ExecuteNonQuery(CrossScripts.AtualizarDessincSadReport);
        }

        public DataTable ObterDessincSadReport()
        {
            return DataContext.Load(CrossScripts.ObterDessincSadReport);
        }

        public void RegistrarLoteDessincSadReport(DessincSadReportLoteData loteData)
        {
            DataContext.ExecuteNonQuery(CrossScripts.RegistrarLoteDessincSadReport, DataParam.Create("Dados", loteData.ToJSon()));
        }
    }
}
