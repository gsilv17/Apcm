using Apcm.Service.Carrinho;
using Apcm.Service.Cross;
using Apcm.Web.Pages.Layout;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Apcm.Web.Pages
{
    public partial class Dessinc : AppPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DefinirAlerta(AlertType, AlertMsg);

            if (IsPostBack)
            {
                return;
            }

            ValidarAdmin();

            Response.Redirect("~/Default.aspx");

        }


        protected void AlternarSelecao_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            GridView grid = (GridView)checkBox.Parent.Parent.Parent.Parent;
            foreach (GridViewRow row in grid.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow && row.Cells[0].FindControl("Selecionado") is CheckBox selecionado && selecionado.Visible)
                {
                    selecionado.Checked = checkBox.Checked;
                }
            }
        }

        protected void Pesquisar_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ProdutoNbr.Text) && int.TryParse(ProdutoNbr.Text, out int produtoNbr))
            {
                List<CrossData> crosses = Services.CrossService.Localizar(produtoNbr, out bool log);

                ProdutoNbr.Enabled = false;
                DessincLocal.Enabled = false;
                DessincTotal.Enabled = false;
                DessincSad.Enabled = false;
                if (crosses.Count == 0 && !log)
                {
                    AlertInfo("Nenhum produto localizado.");
                    ProdutoNbr.Enabled = true;
                }
                else if(crosses.Count == 0 && log)
                {
                    DessincSad.Enabled = true;
                    AlertDanger("O produto só existe no SAD.");
                }
                else
                {
                    DessincLocal.Enabled = true;
                    DessincTotal.Enabled = true;

                    if (crosses.Any(c => c.EmEdicao))
                    {
                        AlertWarning("Existem itens em edição!");
                    }
                }

                GridDessinc.DataSource = crosses;
                GridDessinc.DataBind();
            }
        }

        protected void Limpar_Click(object sender, EventArgs e)
        {
            ProdutoNbr.Text = string.Empty;
            ProdutoNbr.Enabled = true;
            ProdutoNbr.Focus();
            DessincLocal.Enabled = false;
            DessincTotal.Enabled = false;
            DessincSad.Enabled = false;
            GridDessinc.DataSource = new List<CrossData>();
            GridDessinc.DataBind();
        }

        private List<CrossData> ObterCrosses()
        {
            List<CrossData> crosses = new List<CrossData>();
            foreach (GridViewRow row in GridDessinc.Rows)
            {
                if (
                    row.RowType == DataControlRowType.DataRow
                    && row.Cells[0].FindControl("IdCross") is HiddenField IdCross
                    && int.TryParse(IdCross.Value, out int idCross)
                    && row.Cells[0].FindControl("EmEdicao") is HiddenField EmEdicao
                    && bool.TryParse(EmEdicao.Value, out bool emEdicao)
                    && row.Cells[0].FindControl("Selecionado") is CheckBox Selecionado)
                {
                    CrossData cross = new CrossData();
                    cross.IdCross = idCross;
                    cross.EmEdicao = emEdicao;
                    cross.Selecionado = Selecionado.Visible && Selecionado.Checked;
                    crosses.Add(cross);
                }
            }

            return crosses;
        }

        protected void DessincLocal_Click(object sender, EventArgs e)
        {
            List<CrossData> crosses = ObterCrosses();
            if (crosses.Count == 0)
            {
                return;
            }

            int qtdSelecionado = crosses.Count(c => c.Selecionado);
            if (qtdSelecionado == 0)
            {
                AlertInfo("Selecione algum item para remover o link com o produto.");
                return;
            }

            ModalDessinc.Visible = true;

            MsgDessincLocal.Visible = true;
            MsgDessincTotal.Visible = false;
            MsgDessincSad.Visible = false;
            ConfirmarDessincLocal.Visible = true;
            ConfirmarDessincTotal.Visible = false;
            ConfirmarDessincSad.Visible = false;
        }

        protected void DessincTotal_Click(object sender, EventArgs e)
        {
            List<CrossData> crosses = ObterCrosses();
            if (crosses.Count == 0)
            {
                return;
            }

            if (crosses.Any(c => c.EmEdicao))
            {
                AlertInfo("Existem itens em edição!");
                DessincTotal.Enabled = false;
                return;
            }

            int qtdCrosses = crosses.Count();
            int qtdSelecionado = crosses.Count(c => c.Selecionado);
            if (qtdCrosses != qtdSelecionado)
            {
                AlertInfo("Selecione todos os itens para deletar o produto.");
                return;
            }

            ModalDessinc.Visible = true;
            MsgDessincLocal.Visible = false;
            MsgDessincTotal.Visible = true;
            MsgDessincSad.Visible = false;
            ConfirmarDessincLocal.Visible = false;
            ConfirmarDessincTotal.Visible = true;
            ConfirmarDessincSad.Visible = false;
        }

        protected void DessincSad_Click(object sender, EventArgs e)
        {
            ModalDessinc.Visible = true;
            MsgDessincLocal.Visible = false;
            MsgDessincTotal.Visible = false;
            MsgDessincSad.Visible = true;
            ConfirmarDessincLocal.Visible = false;
            ConfirmarDessincTotal.Visible = false;
            ConfirmarDessincSad.Visible = true;
        }
        
        protected void ConfirmarDessincLocal_Click(object sender, EventArgs e)
        {
            List<CrossData> crosses = ObterCrosses().Where(c => c.Selecionado && !c.EmEdicao).ToList();

            bool ok = Services.CrossService.DessincLocal(AppUser.Login, crosses);
            if (ok)
            {
                AlertSuccess("Os itens selecionados foram dessincronizados.");
                Limpar_Click(sender, e);
            }
            else
            {
                AlertDanger("Não foi possível dessincronizar os itens selecionados.");
            }

            ModalDessinc.Visible = false;
        }

        protected void ConfirmarDessincTotal_Click(object sender, EventArgs e)
        {
            try
            {
                CarrinhoDessincSadInclusao parametros = new CarrinhoDessincSadInclusao
                {
                    Produtos = new List<string> { ProdutoNbr.Text },
                    Login = AppUser.Login
                };

                int idCarrinho = Services.Carrinho.CriarCarrinhoDessinc(parametros, AppUser.LoginSad);
                AlertSuccess("O produto foi marcado para dessincronização.");
                Limpar_Click(sender, e);
            }
            catch (Exception ex)
            {
                AlertDanger("Não foi possível dessincronizar o produto selecionado.");
                Services.LogService.Erro("Dessinc.ConfirmarDessincTotal", ex);
            }

            ModalDessinc.Visible = false;
        }

        protected void ConfirmarDessincSad_Click(object sender, EventArgs e)
        {
            ConfirmarDessincTotal_Click(sender, e);
        }

        protected void CancelarDessinc_Click(object sender, EventArgs e)
        {
            ModalDessinc.Visible = false;
        }
    }
}
