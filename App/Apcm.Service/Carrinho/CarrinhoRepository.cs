using System;
using System.Collections.Generic;
using System.Data;
using Apcm.Service.Data;
using Apcm.Service.Item;

namespace Apcm.Service.Carrinho
{
    internal sealed class CarrinhoRepository : DataRepository
    {
        public CarrinhoRepository(DataContext dbContext) : base(dbContext) { }

        [Obsolete]
        public int CriarCarrinhoSams(string scriptCriarCarrinho, List<PesquisaPrateleiraResultado> itens, string login, string tipoProc, string codSistema)
        {
            //DataParam loginParameter = DataParam.Create("Login", login);
            //DataParam tipoProcParameter = DataParam.Create("TipoProc", tipoProc);
            //DataParam codSistemaParameter = DataParam.Create("CodSistema", codSistema);
            //DataTable tbl = DataContext.Load(CarrinhoScripts.SelecionarCarrinhoDataLoad, loginParameter);
            //itens.ForEach(i => i.Login = login);
            //tbl.ReadObject(itens);
            //tbl.TableName = CarrinhoScripts.CarrinhoDataLoad;
            //DataContext.ExecuteBulk(tbl);
            //return DataContext.ExecuteScalar<int>(scriptCriarCarrinho, loginParameter, tipoProcParameter, codSistemaParameter);
            throw new Exception("Obsoleto");
        }

        public int CriarCarrinhoSad(string login, string codSistema)
        {
            return DataContext.ExecuteScalar<int>(CarrinhoScripts.CriarCarrinhoSad, DataParam.Create("Login", login), DataParam.Create("CodSistema", codSistema));
        }

        public int CriarCarrinhoNovo(string login, string guid, DataTable tblBulk, string codSistema)
        {
            try
            {
                DataContext.ExecuteBulk(tblBulk);
                return DataContext.ExecuteScalar<int>(
                    CarrinhoScripts.CriarCarrinhoNovo, 
                    DataParam.Create("Login", login), 
                    DataParam.Create("Guid", guid), 
                    DataParam.Create("CodSistema", codSistema));
            }
            finally
            {
                DataContext.ExecuteNonQuery("Delete From CarrinhoItemBulk Where [Guid] = @Guid", DataParam.Create("Guid", guid));
            }
        }

        public int CriarCarrinhoDessinc(CarrinhoDessincSadInclusao parametros)
        {
            return DataContext.ExecuteScalar<int>(CarrinhoScripts.CriarCarrinhoDessinc, DataParam.Create("Parametros", parametros.ToJSon()));
        }

        public int CriarCarrinhoItemSad(string fieldNames, string parameterNames, DataParam[] parameters)
        {
            return DataContext.ExecuteNonQuery($"Insert Into CarrinhoItem ({fieldNames}) Values ({parameterNames})", parameters);
        }

        public DataTable ItensCarrinhoDisponivel(int idCarrinho)
        {
            return DataContext.Load(CarrinhoScripts.ItensCarrinhoDisponivel, DataParam.Create("IdCarrinho", idCarrinho));
        }

        public List<ItemData> ObterEdicao(string login)
        {
            return DataContext.Load(CarrinhoScripts.ObterEdicao, DataParam.Create("login", login)).ToObject<ItemData>();
        }

        public DataSet ObterExportacao(string scriptObterExportacao, int idCarrinho)
        {
            return DataContext.Fill(scriptObterExportacao, DataParam.Create("IdCarrinho", idCarrinho));
        }

        public DataTable CarrinhosDisponiveis(string login, string codOrigem, string codSistema)
        {
            return DataContext.Load(
                CarrinhoScripts.CarrinhosDisponiveis, 
                new DataParam("Login", login), 
                new DataParam("CodOrigem", codOrigem),
                new DataParam("CodSistema", codSistema));
        }

        public int AtualizarCarrinho(string scriptAtualizacao, DataTable tblBulk, int idCarrinho, string guid)
        {
            try
            {
                DataContext.ExecuteBulk(tblBulk);
                int rCount = DataContext.ExecuteNonQuery(scriptAtualizacao, DataParam.Create("IdCarrinho", idCarrinho), DataParam.Create("Guid", guid));
                return rCount;
            }
            finally
            {
                DataContext.ExecuteNonQuery("Delete From CarrinhoItemBulk Where [Guid] = @Guid", DataParam.Create("Guid", guid));
            }
        }

        public DataTable ObterCarrinho(int idCarrinho)
        {
            return DataContext.Load(CarrinhoScripts.ObterCarrinho, DataParam.Create("IdCarrinho", idCarrinho));
        }

        public DataTable ObterCarrinhoItemEnvio(int idCarrinho)
        {
            return DataContext.Load(CarrinhoScripts.ObterCarrinhoItemEnvio, DataParam.Create("IdCarrinho", idCarrinho));
        }

        public void AtualizarDescrEstrutura(int idCarrinho)
        {
            DataContext.ExecuteNonQuery(CarrinhoScripts.AtualizarDescrEstrutura, DataParam.Create("IdCarrinho", idCarrinho));
        }

        public void RemoverCarrinhoItens(List<int> idsCarrinhoItem, string login)
        {
            List<DataParam[]> parameters = new List<DataParam[]>();
            login = string.IsNullOrEmpty(login) ? string.Empty : login;
            idsCarrinhoItem.ForEach(i => parameters.Add(new DataParam[] { DataParam.Create("IdCarrinhoItem", i), DataParam.Create("Login", login) }));
            DataContext.ExecuteNonQuery(CarrinhoScripts.RemoverCarrinhoItem, parameters.ToArray());
        }

        public DataTable ObterContagemCardHome()
        {
            return DataContext.Load(CarrinhoScripts.ObterContagemCardHome);
        }

        public DataTable DownloadCardCross()
        {
            return DataContext.Load(CarrinhoScripts.DownloadCardCross);
        }

        public DataTable DownloadCardComCross()
        {
            return DataContext.Load(CarrinhoScripts.DownloadCardComCross);
        }

        public DataTable DownloadCardErroRetorno()
        {
            return DataContext.Load(CarrinhoScripts.DownloadCardErroRetorno);
        }

        public DataTable DownloadCardECarrinho()
        {
            return DataContext.Load(CarrinhoScripts.DownloadCardCarrinho);
        }

        public DataTable PesquisaGestaoCarrinho(string filtroJSon)
        {
            return DataContext.Load(CarrinhoScripts.PesquisarGestaoCarrinho, DataParam.Create("filtro", filtroJSon));
        }

        public DataTable ObterCarrinhoItemBulk()
        {
            DataTable tbl = DataContext.Load("Select * From CarrinhoItemBulk Where [Guid] = @Guid", DataParam.Create("Guid", "-1"));
            tbl.TableName = "CarrinhoItemBulk";
            return tbl;
        }
    }
}
