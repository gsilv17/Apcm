using System;
using System.IO;
using System.Web.Routing;
using System.Web.Script.Serialization;
using Apcm.Service;
using Apcm.Service.Data;
using Apcm.Service.Sad;
using Apcm.Service.AppUser;
using Apcm.Web.Properties;

namespace Apcm.Web
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            DirectoryInfo files = new DirectoryInfo(Server.MapPath(Properties.Settings.Default.filesVirtualPath));
            if (!files.Exists)
            {
                files.Create();
            }

            SadService.DefinirUrlsConsulta(
                Settings.Default.SadBaseUrlAtacado,
                Settings.Default.SadBaseUrlVarejo,
                Settings.Default.SadConsultaLote,
                Settings.Default.SadConsultaDetalhe);

            SadService.DefinirUrlsInclusao(
                Settings.Default.SadBaseUrlAtacado,
                Settings.Default.SadBaseUrlVarejo,
                Settings.Default.SadIncluirSolicitacao,
                Settings.Default.SadBuscaProdutos,
                Settings.Default.SadDessinc,
                string.Empty);

            RouteTable.Routes.MapPageRoute("HomeRoute", "Home", "~/Default.aspx");
            RouteTable.Routes.MapPageRoute("ControleAcessoRoute", "ControleAcesso", "~/Pages/ControleAcesso.aspx");
            RouteTable.Routes.MapPageRoute("CarrinhoRoute", "Carrinho", "~/Pages/Carrinho.aspx");
            RouteTable.Routes.MapPageRoute("DessincRoute", "Dessinc", "~/Pages/Dessinc.aspx");
            RouteTable.Routes.MapPageRoute("PesquisaDessincRoute", "PesquisaDessinc", "~/Pages/PesquisaDessinc.aspx");

            RouteTable.Routes.MapPageRoute("GestaoCarrinhoRoute", "GestaoCarrinho", "~/Pages/GestaoCarrinho.aspx");
            RouteTable.Routes.MapPageRoute("PesquisaItensRoute", "PesquisaItens", "~/Pages/PesquisaItens.aspx");
            RouteTable.Routes.MapPageRoute("ConsultaLotesRoute", "ConsultaLotes", "~/Pages/ConsultaLotes.aspx");

            RouteTable.Routes.MapPageRoute("PesquisaProdutosRoute", "PesquisaProdutos", "~/Pages/PesquisaProdutos.aspx");

            RouteTable.Routes.MapPageRoute("NovosProdutosRoute", "NovosProdutos", "~/Pages/NovosProdutos.aspx");


        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session[Properties.Settings.Default.SessionUser] = null;
            try
            {
                AppUserData user = new AppUserData(User, Properties.Settings.Default.DomainServer);
                using (Services services = new Services())
                {
                    services.AppUser.Verificar(user);
                    Session[Properties.Settings.Default.SessionUser] = user;
                }
            }
            catch (Exception ex)
            {
                string path = Server.MapPath("~/Content/files/log.txt");
                File.WriteAllText(path, ex.Message);
                throw;
            }


        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            Session[Properties.Settings.Default.SessionUser] = null;
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}