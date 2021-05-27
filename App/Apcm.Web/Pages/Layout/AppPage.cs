using System;
using System.Globalization;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Apcm.Service;
using Apcm.Service.AppUser;

namespace Apcm.Web.Pages.Layout
{
    public class AppPage: System.Web.UI.Page
    {

        protected Services Services { get; private set; }

        protected AppPageParameters PageParameters { get; private set; }

        protected AppUserData AppUser
        {
            get
            {
                return (AppUserData)Session[Properties.Settings.Default.SessionUser];
            }

            private set
            {
                Session[Properties.Settings.Default.SessionUser] = value;
            }
        }

        private HiddenField AppPageAlertMsg { get; set; }
        private HiddenField AppPageAlertType { get; set; }

        public AppPage()
        {
            Services = new Services();
            Culture = "pt-BR";
        }

        protected override void OnLoad(EventArgs e)
        {
            PageParameters = new AppPageParameters(Session);
            base.OnLoad(e);
        }

        public override void Dispose()
        {
            Services.Dispose();
            base.Dispose();
        }

        public void ValidarAdmin()
        {
            if (!AppUser.Admin)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        public void ValidarEditor()
        {
            if (!AppUser.Editor)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        public bool SistemaAtacado()
        {
            return PageParameters.CodSistema == "Atacado";
        }

        public bool SistemaVarejo()
        {
            return PageParameters.CodSistema == "Varejo";
        }

        public bool SistemaIndefinido()
        {
            return string.IsNullOrEmpty(PageParameters.CodSistema);
        }

        public void ValidarAcesso()
        {
            if(
                SistemaIndefinido()
                || 
                    !AppUser.Admin 
                    &&
                    (
                        !AppUser.Editor
                        || (SistemaAtacado() && !AppUser.Atacado)
                        || (SistemaVarejo() && !AppUser.Varejo)
                    )
                
                )
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        public void ValidarAtacado()
        {
            if (!AppUser.Atacado)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        public void ValidarVarejo()
        {
            if (!AppUser.Varejo)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        public void ValidarEditorOuAdmin()
        {
            if (!AppUser.Editor && !AppUser.Admin)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        public void ObterPerfil()
        {
            AppUserData userData = AppUser;
            Services.AppUser.ObterPerfil(userData);
            AppUser = userData;
        }
        
        public void AbrirModalAlerta(Control modalAlerta)
        {
            modalAlerta.Visible = true;
            ScriptManager.RegisterStartupScript(this, typeof(string), "abrirModalAlerta", string.Format("$('#{0}').modal('show');", modalAlerta.ClientID), true);
        }

        public void FecharModalAlerta(Control modalAlerta)
        {
            modalAlerta.Visible = false;
        }

        public void DefinirAlerta(HiddenField alertType, HiddenField alertMsg)
        {
            AppPageAlertType = alertType;
            AppPageAlertMsg = alertMsg;
            LimparAlerta();
        }

        public void LimparAlerta()
        {
            AppPageAlertType.Value = string.Empty;
            AppPageAlertMsg.Value = string.Empty;
        }

        public void AlertInfo(string format, params object[] args)
        {
            ExibirAlerta("alert-info", string.Format(format, args));
        }

        public void AlertWarning(string format, params object[] args)
        {
            ExibirAlerta("alert-warning", string.Format(format, args));
        }

        public void AlertSuccess(string format, params object[] args)
        {
            ExibirAlerta("alert-success", string.Format(format, args));
        }

        public void AlertDanger(string format, params object[] args)
        {
            ExibirAlerta("alert-danger", string.Format(format, args));
        }

        public void ExibirAlerta(string alertType, string alertMsg)
        {
            AppPageAlertType.Value = alertType;
            AppPageAlertMsg.Value = alertMsg;
        }

    }

    public class AppPageParameters
    {
        private readonly HttpSessionState Session;
        private const string sessionIdCarrinhoInicial = "AppPageParameter_IdCarrinhoInicial";
        private const string sessionLoteInicial = "AppPageParameter_LoteInicial";
        private const string sessionCodOrigem = "AppPageParameter_CodOrigem";
        private const string sessionCodSistema = "AppPageParameter_CodSistema";

        public int IdCarrinhoInicial { get { return Session[sessionIdCarrinhoInicial] == null ? 0 : Convert.ToInt32(Session[sessionIdCarrinhoInicial]); } set { Session[sessionIdCarrinhoInicial] = value; } }
        public string LoteInicial { get { return Session[sessionLoteInicial] == null ? string.Empty : Session[sessionLoteInicial].ToString(); } set { Session[sessionLoteInicial] = value; } }
        public string CodOrigem { get { return Session[sessionCodOrigem] == null ? string.Empty : Session[sessionCodOrigem].ToString(); } set { Session[sessionCodOrigem] = value; } }
        public string CodSistema { get { return Session[sessionCodSistema] == null ? string.Empty : Session[sessionCodSistema].ToString(); } set { Session[sessionCodSistema] = value; } }
        public AppPageParameters(HttpSessionState session)
        {
            Session = session;
        }
    }
}