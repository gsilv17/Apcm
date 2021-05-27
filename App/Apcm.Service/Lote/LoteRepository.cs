using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Apcm.Service.Carrinho;
using Apcm.Service.Data;
using Apcm.Service.Sad;

namespace Apcm.Service.Lote
{
    internal sealed class LoteRepository : DataRepository
    {
        public LoteRepository(DataContext dbContext) : base(dbContext) { }

        /// <summary>
        /// Inclui um lote se inexistente.
        /// </summary>
        /// <param name="idCarrinho">Carrinho do lote.</param>
        /// <param name="numeroLote">Lote.</param>
        /// <returns>Quantidade de registros incluídos.</returns>
        public int Incluir(int idCarrinho, string numeroLote)
        {
            return DataContext.ExecuteNonQuery(
                LoteScripts.Incluir, 
                DataParam.Create("IdCarrinho", idCarrinho), 
                DataParam.Create("NumeroLote", numeroLote));
        }

        public DataTable UltimoLote(int idCarrinho)
        {
            return DataContext.Load(LoteScripts.UltimoLote, DataParam.Create("IdCarrinho", idCarrinho));
        }

        public DataTable LotesPendentes()
        {
            return DataContext.Load(LoteScripts.LotesPendentes);
        }

        public void ConfirmarLote(string numeroLote)
        {
            DataContext.ExecuteNonQuery(LoteScripts.ConfirmarLote, DataParam.Create("NumeroLote", numeroLote));
        }

        public void RegistrarStatusRetornoErro(string statusRetorno, string numeroLote)
        {
            DataContext.ExecuteNonQuery(LoteScripts.RegistrarStatusRetornoErro, DataParam.Create("StatusRetorno", statusRetorno), DataParam.Create("NumeroLote", numeroLote));
        }

        public void RegistrarCarrinhoItemLote(string numeroLote, LoteDetalheMensagem loteDetalheMensagem)
        {
            DataContext.ExecuteNonQuery(
                LoteScripts.RegistrarCarrinhoItemLote,
                DataParam.Create("IdCarrinhoItem", loteDetalheMensagem.idRegistro),
                DataParam.Create("NumeroLote", numeroLote),
                DataParam.Create("CodRetorno", loteDetalheMensagem.CodRet),
                DataParam.Create("StatusRetorno", loteDetalheMensagem.MsgRet),
                DataParam.Create("Filial", string.IsNullOrEmpty(loteDetalheMensagem.Filpfl) ? 0 : int.Parse(loteDetalheMensagem.Filpfl)));
        }

        public bool RegistrarCarrinhoDessinc(CarrinhoDessincRetorno dessincRetorno)
        {
            return DataContext.ExecuteScalar<bool>(LoteScripts.RegistrarCarrinhoDessinc, DataParam.Create("DessincRetorno", dessincRetorno.ToJSon()));
        }

        public DataTable ObterStatusItem(string codOrigem, DateTime? dataDe, DateTime? dataAte)
        {
            return DataContext.Load(
                LoteScripts.ObterStatusItem,
                DataParam.Create("CodOrigem", codOrigem),
                DataParam.Create("DataDe", dataDe ?? null),
                DataParam.Create("DataAte", dataAte ?? null));
        }

        public int ContagemConsultaLote(FiltroConsultaLote filtroPesquisaLote)
        {
            return DataContext.ExecuteScalar<int>(
                LoteScripts.ContagemConsultaLote,
                DataParam.Create("Usuario", filtroPesquisaLote.Usuario),
                DataParam.Create("NumeroLote", filtroPesquisaLote.NumeroLote),
                DataParam.Create("CodOrigem", filtroPesquisaLote.CodOrigem),
                DataParam.Create("DataDe", filtroPesquisaLote.DataDe ?? null),
                DataParam.Create("DataAte", filtroPesquisaLote.DataAte ?? null),
                DataParam.Create("StatusLote", filtroPesquisaLote.StatusLote),
                DataParam.Create("StatusItem", filtroPesquisaLote.StatusItem));
        }

        public DataTable ConsultaLote(FiltroConsultaLote filtroPesquisaLote)
        {
            return DataContext.Load(
                LoteScripts.ConsultaLote,
                DataParam.Create("Usuario", filtroPesquisaLote.Usuario),
                DataParam.Create("NumeroLote", filtroPesquisaLote.NumeroLote),
                DataParam.Create("CodOrigem", filtroPesquisaLote.CodOrigem),
                DataParam.Create("DataDe", filtroPesquisaLote.DataDe ?? null),
                DataParam.Create("DataAte", filtroPesquisaLote.DataAte ?? null),
                DataParam.Create("StatusLote", filtroPesquisaLote.StatusLote),
                DataParam.Create("StatusItem", filtroPesquisaLote.StatusItem));
        }

        public DataTable ConsultaLoteExportacao(FiltroConsultaLote filtroPesquisaLote)
        {
            return DataContext.Load(
                LoteScripts.ConsultaLoteExportacao,
                DataParam.Create("Usuario", filtroPesquisaLote.Usuario),
                DataParam.Create("NumeroLote", filtroPesquisaLote.NumeroLote),
                DataParam.Create("CodOrigem", filtroPesquisaLote.CodOrigem),
                DataParam.Create("DataDe", filtroPesquisaLote.DataDe ?? null),
                DataParam.Create("DataAte", filtroPesquisaLote.DataAte ?? null),
                DataParam.Create("StatusLote", filtroPesquisaLote.StatusLote),
                DataParam.Create("StatusItem", filtroPesquisaLote.StatusItem),
                DataParam.Create("StatusItemExport", filtroPesquisaLote.StatusItemExport));
        }
        
    }
}
