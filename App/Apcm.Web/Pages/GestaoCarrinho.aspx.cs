using Apcm.Service.Carrinho;
using Apcm.Web.Pages.Layout;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Apcm.Web.Pages
{
    public partial class GestaoCarrinho : AppPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AlertMsg.Value = string.Empty;
            ModalRemover.Visible = false;

            if (IsPostBack)
            {
                return;
            }

            ValidarAdmin();
            if (!AppUser.Admin)
            {
                Usuario.Enabled = false;
                Usuario.Text = AppUser.Nome;
            }
        }

        protected void Remover_Click(object sender, EventArgs e)
        {
            List<int> ids = ObtersIdsCarrinhoItemSelecionados();

            if (ids.Count == 0)
            {
                Alert("alert-warning", "Nenhum item selecionado.");
            }
            else if (ids.Count == GridItens.Rows.Count)
            {
                RemoverMsg.Text = "Deseja liberar todos os itens?";
                ModalRemover.Visible = true;
            }
            else
            {
                RemoverMsg.Text = "Deseja liberar os itens selecionados?";
                ModalRemover.Visible = true;
            }
        }

        protected void Pesquisar_Click(object sender, EventArgs e)
        {
            ExecutarPesquisa();
        }

        private void ExecutarPesquisa()
        {
            bool isNumeric(string s) { return long.TryParse(s, out long i); }
            GestaoCarrinhoFiltro filtro = new GestaoCarrinhoFiltro
            {
                Itens = Itens.Text
                    .Replace("\n", " ")
                    .Replace(",", " ")
                    .Replace(";", " ")
                    .Replace("|", " ")
                    .Split(' ')
                    .Distinct()
                    .Where(i => isNumeric(i))
                    .Select(i => long.Parse(i))
                    .Where(i => i > 0)
                    .ToList(),
                Produtos = Produtos.Text
                    .Replace("\n", " ")
                    .Replace(",", " ")
                    .Replace(";", " ")
                    .Replace("|", " ")
                    .Split(' ')
                    .Distinct()
                    .Where(i => isNumeric(i))
                    .Select(i => long.Parse(i))
                    .Where(i => i > 0)
                    .ToList(),
                Usuario = !AppUser.Admin ? AppUser.Login : Usuario.Text
            };

            GridItens.DataSource = Services.Carrinho.PesquisaGestaoCarrinho(filtro);
            GridItens.DataBind();
        }

        protected void Limpar_Click(object sender, EventArgs e)
        {
            Itens.Text = string.Empty;
            Produtos.Text = string.Empty;
            GridItens.DataSource = new List<GestaoCarrinhoItens>();
            GridItens.DataBind();
            Usuario.Text = !AppUser.Admin ? AppUser.Nome : string.Empty;
        }

        protected void Alert(string alertType, string alertMsg)
        {
            AlertType.Value = alertType;
            AlertMsg.Value = alertMsg;
        }

        private List<int> ObtersIdsCarrinhoItemSelecionados()
        {
            List<int> ids = new List<int>();
            foreach (GridViewRow row in GridItens.Rows)
            {
                if (
                    row.RowType == DataControlRowType.DataRow
                    && row.FindControl("Selecionado") is CheckBox selecionado
                    && selecionado.Checked
                    && row.FindControl("IdCarrinhoItem") is HiddenField idCarrinhoItem
                    && int.TryParse(idCarrinhoItem.Value, out int id))
                {
                    ids.Add(id);
                }
            }
            return ids;
        }

        protected void AlternarSelecao_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox alternarSelecao = sender as CheckBox;
            foreach (GridViewRow row in GridItens.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox selecionado = row.FindControl("Selecionado") as CheckBox;
                    selecionado.Checked = alternarSelecao.Checked;
                }
            }
        }

        protected void ConfirmarRemover_Click(object sender, EventArgs e)
        {
            List<int> ids = ObtersIdsCarrinhoItemSelecionados();

            Services.Carrinho.RemoverCarrinhoItens(ids, AppUser.Login);
            ExecutarPesquisa();
            ModalRemover.Visible = false;
            Alert("alert-success", "Itens liberados.");

        }

        protected void CancelarRemover_Click(object sender, EventArgs e)
        {
            ModalRemover.Visible = false;
            Alert("alert-info", "Os itens não foram liberados.");
        }

    }
}