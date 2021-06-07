using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Apcm.Service;
using Apcm.Service.AppUser;
using System.Linq;

namespace Apcm.Web.Pages.Layout
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public AppUserData UserData { get { return (AppUserData)Session[Properties.Settings.Default.SessionUser]; } }

        public AppPageParameters pageParameters;

        protected void Page_Load(object sender, EventArgs e)
        {
            DefinirMenu();
            Nome.Text = UserData.Nome;
            pageParameters = new AppPageParameters(Session);
        }

        private void DefinirMenu()
        {
            MenuAdministrador.Visible = UserData.Admin;
            MenuAtacado.Visible = UserData.Admin || (UserData.Editor && UserData.Atacado);
            MenuVarejo.Visible = UserData.Admin || (UserData.Editor && UserData.Varejo);
        }

        protected void atualizarPerfil_Click(object sender, EventArgs e)
        {
            Session[Properties.Settings.Default.SessionUser] = null;
            AppUserData user = new AppUserData(Page.User, Properties.Settings.Default.DomainServer);
            using (Services services = new Services())
            {
                services.AppUser.Verificar(user);
                Session[Properties.Settings.Default.SessionUser] = user;
            }

            DefinirMenu();
        }

        protected void Carrinho_Click(object sender, EventArgs e)
        {
            pageParameters.CodOrigem = "Sad";
            pageParameters.CodSistema = ((LinkButton)sender).CommandArgument;
            Response.Redirect("~/Carrinho");
        }

        protected void ConsultaLotesManutencao_Click(object sender, EventArgs e)
        {
            pageParameters.CodOrigem = "Sad";
            pageParameters.CodSistema = ((LinkButton)sender).CommandArgument;
            Response.Redirect("~/ConsultaLotes");
        }

        protected void ConsultaLotesNovo_Click(object sender, EventArgs e)
        {
            pageParameters.CodOrigem = "Novo";
            pageParameters.CodSistema = ((LinkButton)sender).CommandArgument;
            Response.Redirect("~/ConsultaLotes");
        }

        protected void GestaoCarrinho_Click(object sender, EventArgs e)
        {
            pageParameters.CodOrigem = "Sad";
            pageParameters.CodSistema = ((LinkButton)sender).CommandArgument;
            Response.Redirect("~/GestaoCarrinho");
        }

        protected void PesquisaProdutos_Click(object sender, EventArgs e)
        {
            pageParameters.CodSistema = ((LinkButton)sender).CommandArgument;
            Response.Redirect("~/PesquisaProdutos");
        }

        protected void NovosProdutos_Click(object sender, EventArgs e)
        {
            pageParameters.CodSistema = ((LinkButton)sender).CommandArgument;
            Response.Redirect("~/NovosProdutos");
        }
    }
}