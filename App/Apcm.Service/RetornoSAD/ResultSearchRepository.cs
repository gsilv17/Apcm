using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Apcm.Service.Data;

namespace Apcm.Service.RetornoSAD
{
    internal class ResultSearchRepository : DataRepository
    {
        public ResultSearchRepository(DataContext dataContext) : base(dataContext) { }

        public List<ResultSearchData> Pesquisar(string login, string lote, string msgRetorno, string statusLote)
        {
            try
            {
                string sql = "";
                if (!string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && !string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnFull;
                }

                if (!string.IsNullOrWhiteSpace(msgRetorno) && string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(login))
                {
                    sql = SearchScripts.SearchReturnByMsgRetorno;
                }

                if (!string.IsNullOrWhiteSpace(login) && string.IsNullOrWhiteSpace(lote) && !string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnMsgRetornoLogin;
                }

                if (string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && !string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnMsgRetoroLote;
                }

                if (!string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturn;
                }

                if (string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnByLote;
                }

                if (!string.IsNullOrWhiteSpace(login) && string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnByLogin;
                }
                

                if (string.IsNullOrWhiteSpace(login) && string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnNoFilters;
                }

                DataTable dt = DataContext.Load(
                     sql,
                     new DataParam("Login", login),
                     new DataParam("Lote", lote),
                     new DataParam("MsgRetorno", msgRetorno));

                List<ResultSearchData> listaRetorno = PreencherData(dt);

                if(!string.IsNullOrWhiteSpace(statusLote) && listaRetorno.Count > 0)
                {
                    if(statusLote.Equals("1"))
                    {
                        listaRetorno = listaRetorno.Where(x => x.StatusRetornoLote == "Processado").ToList();
                    }

                    if (statusLote.Equals("2"))
                    {
                        listaRetorno = listaRetorno.Where(x => x.StatusRetornoLote == "Não Processado").ToList();
                    }


                }

                return listaRetorno;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public DataTable ObterRetornoStatusItemError(string login, string lote, string msgRetorno, string statusLote)
        {
            try
            {
                string sql = "";

                if (!string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && !string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemErrorFull;
                }

                if (!string.IsNullOrWhiteSpace(msgRetorno) && string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(login))
                {
                    sql = SearchScripts.SearchReturnStatusItemErrorByMsgRetorno;
                }

                if (!string.IsNullOrWhiteSpace(login) && string.IsNullOrWhiteSpace(lote) && !string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemErrorMsgRetornoLogin;
                }

                if (string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && !string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemErrorMsgRetornoLote;
                }

                if (!string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno)  )
                {
                    sql = SearchScripts.SearchReturnStatusItemError;
                }

                if (string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemErrorByLote;
                }

                if (!string.IsNullOrWhiteSpace(login) && string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemErrorByLogin;
                }

                if (string.IsNullOrWhiteSpace(login) && string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnErrorNoFilters;
                }

                DataTable dtRetorno = DataContext.Load(
                         sql,
                         new DataParam("Login", login),
                         new DataParam("Lote", lote),
                         new DataParam("MsgRetorno", msgRetorno));


                if (!string.IsNullOrWhiteSpace(statusLote) && dtRetorno.Rows.Count > 0)
                {
                    if (statusLote.Equals("1"))
                    {
                        dtRetorno = dtRetorno.AsEnumerable().Where(x => x.Field<string>("StatusRetornoLote") == "Processado").CopyToDataTable();
                    }

                    if (statusLote.Equals("2"))
                    {
                        dtRetorno = dtRetorno.AsEnumerable().Where(x => x.Field<string>("StatusRetornoLote") == "Não Processado").CopyToDataTable();
                    }
                }

                return DataContext.Load(
                         sql,
                         new DataParam("Login", login),
                         new DataParam("Lote", lote),
                         new DataParam("MsgRetorno", msgRetorno));
            }
            catch (Exception EX)
            {

                throw EX; 
            }
            
        }

        public DataTable ObterRetornoStatusItemSuccess(string login, string lote, string msgRetorno, string statusLote)
        {
            try
            {
                string sql = "";
                if (!string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && !string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemSuccessFull;
                }

                if (!string.IsNullOrWhiteSpace(msgRetorno) && string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(login))
                {
                    sql = SearchScripts.SearchReturnStatusItemSuccessByMsgRetorno;
                }

                if (!string.IsNullOrWhiteSpace(login) && string.IsNullOrWhiteSpace(lote) && !string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemSuccessMsgRetornoLogin;
                }

                if (string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && !string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemSuccessMsgRetornoLote;
                }

                if (!string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemSuccess;
                }

                if (string.IsNullOrWhiteSpace(login) && !string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemSuccessByLote;
                }

                if (!string.IsNullOrWhiteSpace(login) && string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnStatusItemSuccessByLogin;
                }

                if (string.IsNullOrWhiteSpace(login) && string.IsNullOrWhiteSpace(lote) && string.IsNullOrWhiteSpace(msgRetorno))
                {
                    sql = SearchScripts.SearchReturnSuccessNoFilters;
                }

                DataTable dtRetorno = DataContext.Load(
                     sql,
                     new DataParam("Login", login),
                     new DataParam("Lote", lote),
                     new DataParam("MsgRetorno", msgRetorno));


                if (!string.IsNullOrWhiteSpace(statusLote) && dtRetorno.Rows.Count > 0)
                {
                    if (statusLote.Equals("1"))
                    {
                        dtRetorno = dtRetorno.AsEnumerable().Where(x => x.Field<string>("StatusRetornoLote") == "Processado").CopyToDataTable();
                    }

                    if (statusLote.Equals("2"))
                    {
                        dtRetorno = dtRetorno.AsEnumerable().Where(x => x.Field<string>("StatusRetornoLote") == "Não Processado").CopyToDataTable();
                    }
                }
                return dtRetorno;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public DataTable ObterFiltroStatusRetorno()
        {
            
               string sql = SearchScripts.SearchFiltroStatus;
            
            DataTable dtRetorno = DataContext.Load(
                 sql);

            return dtRetorno;
        }

        private List<ResultSearchData> PreencherData(DataTable dt)
        {
            List<ResultSearchData> lista = new List<ResultSearchData>();
            if (dt == null)
                return lista;
            lista = (from DataRow item in dt.Rows
                     select new ResultSearchData
                     {
                         Usuario = item["Usuario"].ToString(),
                         StatusRetorno = item["StatusRetorno"].ToString(),
                         CodProdutoSAD = Int32.Parse(item["CodProdutoSAD"].ToString()),
                         DescricaoItem = item["DescricaoItem"].ToString(),
                         CodVendor = item["CodVendor"].ToString(),
                         DescVendor = item["DescVendor"].ToString(),
                         CodigoCategoria = Int32.Parse(item["CodigoCategoria"].ToString()),
                         DescCategoria = item["DescCategoria"].ToString(),
                         CodigoSubCategoria = Int32.Parse(item["CodigoSubCategoria"].ToString()),
                         DescSubCategoria = item["DescSubCategoria"].ToString(),
                         Lote = item["Lote"].ToString(),
                         CodItemLink = Int32.Parse(item["CodItemLink"].ToString()),
                         DiaHoraSelecionado = item["DiaHoraSelecionado"].ToString(),
                         CodFineLine = Int32.Parse(item["CodFineLine"].ToString()),
                         Upc = item["Upc"].ToString(),
                         SigningDesc = item["SigningDesc"].ToString(),
                         VnpkQty = Int32.Parse(item["VnpkQty"].ToString()),
                         CaseUpc = item["CaseUpc"].ToString(),
                         MdseOrignCode = Int32.Parse(item["MdseOrignCode"].ToString()),
                         VendorStockId = item["VendorStockId"].ToString(),
                         VnpkCosAmt = Decimal.Parse(item["VnpkCosAmt"].ToString()),
                         ItemLengthQty = Decimal.Parse(item["ItemLengthQty"].ToString()),
                         ItemWidthQty = Decimal.Parse(item["ItemWidthQty"].ToString()),
                         ItemHeightQty = Decimal.Parse(item["ItemHeightQty"].ToString()),
                         MiRrcvngDaysQty = Int32.Parse(item["MiRrcvngDaysQty"].ToString()),
                         IpiTaxClassCd = Int32.Parse(item["IpiTaxClassCd"].ToString()),
                         DataEnvio = item["DataEnvio"].ToString(),
                         StatusRetornoLote = item["StatusRetornoLote"].ToString()

                     }).ToList();
            return lista;
        }
    }
}
