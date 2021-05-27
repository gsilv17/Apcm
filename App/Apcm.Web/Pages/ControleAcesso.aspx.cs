using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Apcm.Service.AppUser;
using Apcm.Web.Pages.Layout;

namespace Apcm.Web.Pages
{
    public partial class ControleAcesso : AppPage
    {
        protected IAppUserService UserService => Services.AppUser;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            FecharModalAlerta(modalAlerta);
            
            if (IsPostBack)
            {
                return;
            }

            ModoVisualizacao.Value = "0";
            ValidarAdmin();
            Localizar(this, new EventArgs());
        }
        
        protected void Localizar(object sender, EventArgs e)
        {
            ExibirDados(UserService.Localizar(int.Parse(ModoVisualizacao.Value), Pesquisa.Text.Trim()));
        }

        private void ExibirDados(List<AppUserData> users)
        {
            GridView.DataSource = users;
            GridView.DataBind();
            qtdUsuarios.Text = users.Count.ToString("N0", new System.Globalization.CultureInfo("pt-br"));
        }

        protected void btnModoVisualizacao(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string cssClass = "btn btn-secondary";
            btnTodos.CssClass = cssClass;
            btnNovos.CssClass = cssClass;
            btnAdmins.CssClass = cssClass;
            btnEditores.CssClass = cssClass;
            btnAtacado.CssClass = cssClass;
            btnVarejo.CssClass = cssClass;
            btn.CssClass = string.Join(" ", cssClass, "active");
            ModoVisualizacao.Value = btn.ID == btnNovos.ID ? "1" : btn.ID == btnAdmins.ID ? "2" : btn.ID == btnEditores.ID ? "3" : btn.ID ==btnAtacado.ID ? "4" : btn.ID == btnVarejo.ID ? "5" : "0";
            TipoFiltro.Text = btn.ID == btnNovos.ID ? "Novos Usuários Localizados" : btn.ID == btnAdmins.ID ? "Administradores Localizados" : btn.ID == btnEditores.ID ? "Editores Localizados" : btn.ID == btnAtacado.ID ? "Acessos Sam's Localizados" : btn.ID == btnVarejo.ID ? "Acessos Varejo Localizados" : "Usuarios Localizados";
            Localizar(sender, e);
        }

        protected void btnAdicionar_Click(object sender, EventArgs e)
        {
            string loginRede = LoginUsuario.Text.Trim().ToLower();
            string loginSad = LoginSad.Text.Trim().ToLower();

            if (string.IsNullOrEmpty(loginRede) || string.IsNullOrEmpty(loginSad))
            {
                return;
            }

            if (UserService.Incluir(loginRede, loginSad, UsuarioAdmin.Checked, UsuarioEditor.Checked, UsuarioAtacado.Checked, UsuarioVarejo.Checked))
            {
                Localizar(sender, e);
                modalAlertaMensagem.Text = string.Format("Usuário {0} - {1} incluído com sucesso!", loginRede, loginSad);
            }
            else
            {
                modalAlertaMensagem.Text = string.Format("Usuário Rede e/ou SAD {0} - {1} já existe!", loginRede, loginSad);
            }

            modalAlertaTitulo.Text = "Incluir";
            AbrirModalAlerta(modalAlerta);
        }

        protected void AdminEditor_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            GridViewRow gridViewRow = (GridViewRow)checkBox.Parent.Parent;
            CheckBox admin = (CheckBox)gridViewRow.FindControl("Admin");
            CheckBox editor = (CheckBox)gridViewRow.FindControl("Editor");
            CheckBox atacado = (CheckBox)gridViewRow.FindControl("Atacado");
            CheckBox varejo = (CheckBox)gridViewRow.FindControl("Varejo");

            string login = gridViewRow.Cells[0].Text;
            UserService.Atualizar(login, admin.Checked, editor.Checked, atacado.Checked, varejo.Checked);
        }


        protected void LoginSad_TextChanged(object sender, EventArgs e)
        {
            TextBox loginsad = (TextBox)sender;
            GridViewRow gridViewRow = (GridViewRow)loginsad.Parent.Parent;
            string login = gridViewRow.Cells[0].Text;
            HiddenField hdnLoginSad = (HiddenField)gridViewRow.FindControl("HdnLoginSad");

            if (string.IsNullOrEmpty(loginsad.Text) || !UserService.Atualizar(login, loginsad.Text))
            {
                modalAlertaTitulo.Text = "Login SAD";
                modalAlertaMensagem.Text =
                    string.IsNullOrEmpty(loginsad.Text) ?
                    "Campo obriatório!" :
                    $"O Login Sad informado ({loginsad.Text}) já está em uso";
                loginsad.Text = hdnLoginSad.Value;
                AbrirModalAlerta(modalAlerta);
            } else
            {
                hdnLoginSad.Value = loginsad.Text;
            }
        }

        protected void Excluir_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            GridViewRow gridViewRow = (GridViewRow)button.Parent.Parent;
            string login = gridViewRow.Cells[0].Text;
            UserService.Excluir(login);
            Localizar(sender, e);
        }

        protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                AppUserData user = (AppUserData)e.Row.DataItem;
                if (!string.IsNullOrEmpty(user.Nome))
                {
                    Control button = e.Row.FindControl("ExibirExcluir");
                    button.Visible = false;
                }
            }
        }

        protected void ConfirmarExcluir_Click(object sender, EventArgs e)
        {
            UserService.Excluir(LoginExclusao.Text);
            LoginExclusao.Text = string.Empty;
            ModalExcluir.Visible = false;
            Localizar(sender, e);
        }

        protected void CancelarExcluir_Click(object sender, EventArgs e)
        {
            ModalExcluir.Visible = false;
        }

        protected void ExibirExcluir_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton button = sender as ImageButton;
            GridViewRow gridViewRow = button.Parent.Parent as GridViewRow;
            string login = gridViewRow.Cells[0].Text;
            LoginExclusao.Text = login;
            ModalExcluir.Visible = true;
        }

        
        protected void Atacado_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}


//protected void btnExpand_Command(object sender, CommandEventArgs e)
//{
//    List<User> usuarios = this.usuarios;
//    User usuario = usuarios.Single(u => u.Nome.Equals(e.CommandArgument));
//    usuario.Expand = !usuario.Expand;
//    Repeater.DataSource = usuarios;
//    Repeater.DataBind();
//    this.usuarios = usuarios;
//}

//protected void Repeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
//{
//    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
//    {
//        User usuario = (User)e.Item.DataItem;
//        Control trDetail = e.Item.FindControl("trDetail");
//        if (usuario.Expand)
//        {
//            GridView gridViewDetail = (GridView)trDetail.FindControl("gridViewDetail");
//            gridViewDetail.DataSource = usuario.Mails;
//            gridViewDetail.DataBind();
//        }
//        else
//        {
//            trDetail.Visible = false;
//        }
//    }
//}