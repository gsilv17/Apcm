using Apcm.RetornoSad.BD;
using Apcm.RetornoSad.Retornos;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace Apcm.RetornoSad.Businness
{
    internal class ProcessamentoRetorno
    {


        public void ProcessarRetorno()
        {
            ConsultaRetorno consulta = new ConsultaRetorno();
            string strConn = ConfigurationManager.ConnectionStrings["strConn"].ConnectionString;
            
            RetornoConsultaBD retControle = consulta.InserirControle(strConn, "ConsultaLoteSAD");
            int idControle = Int32.Parse(retControle.RetornoDt.Rows[0][0].ToString());
                      
            RetornoConsultaBD retornoConsulta = consulta.ConsultarLotesNaoProcessados(strConn);
            Lote dadosLote = new Lote();
            RetornoConsultaLote retLote;
            ConsultaRetornoFEP procRet = new ConsultaRetornoFEP();
            RetornoConsultaDetalheLote retDetalhe;
            List<Lote> listaLotesNaoProcessados = dadosLote.ConverterLista(retornoConsulta.RetornoDt);
            int totalLotesProcessados = 0;
            if (listaLotesNaoProcessados.Count > 0)
            {
                foreach (var item in listaLotesNaoProcessados)
                {
                    retLote = procRet.ConsultaLote(item.NumeroLote);
                    if (retLote.mensagemRetorno.ToUpper().Equals("LOTE PROCESSADO."))
                    {
                        consulta.AtualizarLote(strConn, item.IdLote, retLote.mensagemRetorno);
                        retDetalhe = procRet.ConsultaLoteDetalhe(item.NumeroLote);
                        AtualizarDadosDetalheLote(retDetalhe, item.IdLote, strConn);
                        totalLotesProcessados += 1;
                    }
                }
            }
            consulta.AtualizarControle(strConn, idControle, totalLotesProcessados);
            dadosLote = null;
            consulta = null;
            procRet = null;
        }

        private void AtualizarDadosDetalheLote(RetornoConsultaDetalheLote dadosRetorno, int idLote, string strConn)
        {
            ConsultaRetornoFEP procRetDetalhe = new ConsultaRetornoFEP();
            ConsultaRetorno consultaDetalhe = new ConsultaRetorno();
            CrossItemProcessamento cItProc = new CrossItemProcessamento();
            foreach (var item in dadosRetorno.mensagem)
            {
                item.MsgRet = item.MsgRet.Replace("'", "");
                consultaDetalhe.InserirCarrinhoItemLote(strConn, item.idRegistro, idLote, item.CodRet, item.MsgRet, item.Filpfl);
                if(item.CodRet.Equals("000"))
                {
                    consultaDetalhe.AtualizarCarrinhoItem(strConn, item.idRegistro);
                    cItProc.ProcessarCrossItem(strConn, item.idRegistro, item.CodProd, item.Cean, item.Tean, item.Eandg);
                }
            }
            procRetDetalhe = null;
            consultaDetalhe = null;
            cItProc = null;
        }
    }
}
