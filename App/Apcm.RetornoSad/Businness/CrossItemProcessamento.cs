using Apcm.RetornoSad.BD;
using Apcm.RetornoSad.Retornos;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.RetornoSad.Businness
{
    internal class CrossItemProcessamento
    {
        public void ProcessarCrossItem(string strConn, int idCarrinhoItem, int codProdSAD, string eanSAD, int Tean, int EanDig)
        {
            RetornoGenerico ret = ObterIdCross(strConn, idCarrinhoItem);
            if (ret.CodOrigem == "Sams")
            {
                if (ret.Id == 0)
                {
                    InserirDadosCross(strConn, idCarrinhoItem, codProdSAD, eanSAD, Tean, EanDig);
                }
                else
                {
                    AtualizarDadosCross(strConn, idCarrinhoItem, codProdSAD, ret.Id, eanSAD, Tean, EanDig);
                }
            }
            else
            {
                AtualizarDadosCrossProduto(strConn, idCarrinhoItem);
            }
        }

        private RetornoGenerico ObterIdCross(string strConn, int idCarrinhoItem)
        {
            CrossItemDB crossDb = new CrossItemDB();

            RetornoConsultaBD retCodOrigem = crossDb.ObterCodOrigem(strConn, idCarrinhoItem);
            string codOrigem = retCodOrigem.RetornoDt.Rows[0][0].ToString();

            if (codOrigem == "Sams")
            {
                RetornoConsultaBD retBd = crossDb.ObterIdCrossItem(strConn, idCarrinhoItem);
                if (retBd.RetornoDt == null)
                    return new RetornoGenerico { Sucesso = true, Id = 0, CodOrigem = codOrigem };
                if (retBd.RetornoDt.Rows.Count <= 0)
                    return new RetornoGenerico { Sucesso = true, Id = 0, CodOrigem = codOrigem };

                return new RetornoGenerico { Sucesso = true, Id = Int32.Parse(retBd.RetornoDt.Rows[0]["IDCROSSITEM"].ToString()), CodOrigem = codOrigem };
            }
            else
            {
                return new RetornoGenerico { Sucesso = true, Id = -1, CodOrigem = codOrigem };
            }
        }

        private RetornoGenerico InserirDadosCross(string strConn, int idCarrinhoItem, int sadCodProdu, string eanSAD, int Tean, int EanDig)
        {
            ConsultaRetorno consultaRet = new ConsultaRetorno();
            RetornoConsultaBD retBd = consultaRet.ObterDadosCarrinhoItem(strConn, idCarrinhoItem);
            List<DadosItem> dados = new DadosItem().PreencherData(retBd.RetornoDt);
            if (dados.Count <= 0)
                return new RetornoGenerico { Sucesso = false, Mensagem = "Dados não encontrados" };

            CrossItem dadosCross = PreencherDadosCross(dados[0], idCarrinhoItem, sadCodProdu, Tean, EanDig);
            
            dadosCross.SadCodigoEan = eanSAD;
            CrossItemDB crossDb = new CrossItemDB();
            return crossDb.InserirCrossItem(strConn, dadosCross);
        }

        private RetornoGenerico AtualizarDadosCross(string strConn, int idCarrinhoItem, int sadCodProdu, int idCross, string eanSAD, int Tean, int EanDig)
        {
            CrossItemDB crossDb = new CrossItemDB();
            RetornoConsultaBD retBd = crossDb.ObterCrossItem(strConn, idCross);
            List<CrossItem> dadosCross = new CrossItem().ConverterDados(retBd.RetornoDt);
            dadosCross[0].ItemDesc = dadosCross[0].ItemDesc.Replace("'", "''");
            crossDb.InserirCrossItemLog(strConn, dadosCross[0], idCross);

            ConsultaRetorno consultaRet = new ConsultaRetorno();
            retBd = consultaRet.ObterDadosCarrinhoItem(strConn, idCarrinhoItem);
            List<DadosItem> dados = new DadosItem().PreencherData(retBd.RetornoDt);
            if (dados.Count <= 0)
                return new RetornoGenerico { Sucesso = false, Mensagem = "Daos não encontrados" };

            return crossDb.AtualizarCrossItem(strConn, PreencherDadosCross(dados[0], idCarrinhoItem, sadCodProdu, Tean, EanDig), idCross, eanSAD);
        }

        private RetornoGenerico AtualizarDadosCrossProduto(string strConn, int idCarrinhoItem)
        {
            CrossItemDB crossDb = new CrossItemDB();
            return crossDb.AtualizarCrossProduto(strConn, idCarrinhoItem);
        }

        private CrossItem PreencherDadosCross(DadosItem dados, int idCarrinhoItem, int sadCodProdu, int Tean, int EanDig)
        {
            CrossItem dadosCross = new CrossItem();
            dadosCross.IdCarrinhoItem = idCarrinhoItem;
            dadosCross.ItemDesc = dados.DescricaoItem.Replace("'","''");
            dadosCross.Multipack = dados.Multipack;
            dadosCross.Qtdepack = dados.PackFornecedor;
            dadosCross.SadCodigoEan = "0";
            dadosCross.SadCodProdu = sadCodProdu;
            dadosCross.SamsItemId = dados.CodItemOif;
            dadosCross.SamsPluNbr = 0;
            dadosCross.SamsUpcNbr = dados.Upc;
            dadosCross.SamsVendorNbr = dados.CodVendor;
            dadosCross.StatusItem = "";
            dadosCross.UpcReal = dados.Upc;
            dadosCross.DigitoUpcReal = dados.DigitoUpcReal;
            dadosCross.TipoEan = Tean;
            dadosCross.EanDig = EanDig;
            return dadosCross;
        }
    }
}
