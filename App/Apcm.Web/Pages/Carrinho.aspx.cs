using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Apcm.Service.Carrinho;
using Apcm.Service.Lote;
using Apcm.Web.Pages.Layout;

namespace Apcm.Web.Pages
{
    public partial class Carrinho : AppPage
    {
        protected bool PodeRemover { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidarAcesso();

            Alert(string.Empty, string.Empty);
            iFrameDownload.Src = string.Empty;
            ModalRemover.Visible = false;
            fileUpXlsLabel.Text = "Selecione um arquivo...";

            if (IsPostBack)
            {
                return;
            }

            PreencherCarrinhos(true);

            FileUpXls.Attributes.Add("aria-describedby", Importar.ClientID);
        }

        private void PreencherCarrinhos()
        {
            PreencherCarrinhos(false);
        }

        private void PreencherCarrinhos(bool verificarCarrinhoInicial)
        {
            IDictionary<int, string> carrinhosDisponiveis = Services.Carrinho.CarrinhosDisponiveis(AppUser.Login , PageParameters.CodOrigem, PageParameters.CodSistema);
            IDictionary<int, string> carrinhosDisponiveisOrdenados = new Dictionary<int, string>();
            carrinhosDisponiveisOrdenados[0] = carrinhosDisponiveis.Count == 0 ? "Nenhum" : "Selecione";
            carrinhosDisponiveis.Cast<KeyValuePair<int, string>>().ToList().ForEach(c => carrinhosDisponiveisOrdenados.Add(c));
            Carrinhos.DataSource = carrinhosDisponiveisOrdenados; 
            Carrinhos.DataBind();
            Carrinhos.Enabled = carrinhosDisponiveis.Count > 0;

            if (verificarCarrinhoInicial && PageParameters.IdCarrinhoInicial > 0 && carrinhosDisponiveis.ContainsKey(PageParameters.IdCarrinhoInicial))
            {
                Carrinhos.SelectedValue = PageParameters.IdCarrinhoInicial.ToString();
                ApresentarCarrinho();
                if (Exportar.Enabled)
                {
                    Exportar_Click(null, null);
                }

                PageParameters.IdCarrinhoInicial = 0;
            }
            else
            {
                PageParameters.IdCarrinhoInicial = 0;
                ApresentarCarrinho();
            }
        }

        private void PodeExportar(bool permitir)
        {
            Exportar.Enabled = permitir;
            Exportar.CssClass = string.Format("btn btn-secondary ts-modal-espera-click w-100 {0}", permitir ? "" : "disabled");
        }

        private void PodeImportar(bool permitir)
        {
            Importar.Enabled = permitir;
            Importar.CssClass = string.Format("btn btn-secondary ts-modal-espera-click {0}", permitir ? "" : "disabled");
            FileUpXls.Enabled = permitir;
            FileUpXls.CssClass = string.Format("custom-file-input {0}", permitir ? "" : "disabled");
        }

        private void PodeEnviar(bool permitir)
        {
            Enviar.Enabled = permitir;
            Enviar.CssClass = string.Format("btn btn-{0} ts-modal-espera-click {1}", permitir ? "success" : "secondary",  permitir ? "" : "disabled");
        }

        protected void Carrinhos_SelectedIndexChanged(object sender, EventArgs e)
        {
            ApresentarCarrinho();
        }

        private void ApresentarCarrinho()
        {
            int idCarrinho = int.Parse(Carrinhos.SelectedValue);
            bool origemSams = OrigemSams();

            List<CarrinhoItemData> itens = idCarrinho > 0 ? Services.Carrinho.ItensCarrinhoDisponivel(idCarrinho) : null;
            LoteData ultimoLote = Services.LoteService.UltimoLote(idCarrinho);
            string strUltimoLote = ultimoLote != null && idCarrinho > 0 ? ultimoLote.NumeroLote : "Carrinho não enviado.";

            if (origemSams)
            {
                UltimoLote.Text = strUltimoLote;
            }
            else
            {
                UltimoLoteSad.Text = strUltimoLote;
            }

            PodeRemover = ultimoLote == null && idCarrinho > 0;
            Remover.Enabled = PodeRemover;
            Remover.CssClass = string.Format("btn btn-secondary ts-modal-espera-click {0}", PodeRemover ? "" : "disabled");

            dvGridItens.Visible = origemSams;
            dvGridProdutos.Visible = !origemSams;

            GridView grid = origemSams ? GridItens : GridProdutos;
            grid.DataSource = itens;
            grid.DataBind();

            PodeExportar(idCarrinho > 0);
            PodeImportar(idCarrinho > 0);

            PodeEnviar(false);
        }

        protected void Exportar_Click(object sender, EventArgs e)
        {
            int idCarrinho = int.Parse(Carrinhos.SelectedValue);
            FileInfo outputFile = Services.Carrinho.Exportar(idCarrinho, MapPath(Properties.Settings.Default.filesVirtualPath));
            string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, outputFile.Name);
            string downloadPath = ResolveUrl(downloadVirtualPath);
            iFrameDownload.Src = downloadPath;
            string msg = PageParameters.IdCarrinhoInicial > 0 ? $"Carrinho {idCarrinho.ToString("N0")} criado. " : string.Empty;
            Alert("alert-success", string.Format("{0}O arquivo {1} foi exportado com sucesso.", msg, outputFile.Name));
        }

        protected void Importar_Click(object sender, EventArgs e)
        {
            int idCarrinho = int.Parse(Carrinhos.SelectedValue);

            if (!FileUpXls.HasFile)
            {
                Alert("alert-warning", "Nenhum arquivo selecionado.");
                return;
            }

            fileUpXlsLabel.Text = FileUpXls.PostedFile.FileName;

            if (FileUpXls.PostedFile.ContentType != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
            {
                Alert("alert-warning", "O arquivo informado não é do tipo esperado.");
                return;
            }

            try
            {
                ImportResult result = Services.Carrinho.Importar(
                    FileUpXls.PostedFile.InputStream,
                    idCarrinho,
                    AppUser.Login,
                    MapPath(Properties.Settings.Default.filesVirtualPath),
                    PageParameters.CodSistema);

                iFrameDownload.Src = string.Empty;
                if (result.OutputFile != null)
                {
                    string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, result.OutputFile.Name);
                    string downloadPath = ResolveUrl(downloadVirtualPath);
                    iFrameDownload.Src = downloadPath;
                }



                Alert(result.AlertType, result.AlertMsg);

                ApresentarCarrinho();

                PodeEnviar(result.PodeEnviar);
            }
            catch (Exception ex)
            {
                Alert("alert-warning", ex.Message);
            }
        }

        protected void Enviar_Click(object sender, EventArgs e)
        {
            PodeEnviar(false);
            int idCarrinho = int.Parse(Carrinhos.SelectedValue);
            try
            {
                string lote = Services.Carrinho.Enviar(idCarrinho);
                Alert("alert-success", $"Lote {lote} gerado com sucesso.");
                ApresentarCarrinho();
                PageParameters.LoteInicial = lote;
                Response.Redirect("~/ConsultaLotes");
            }
            catch (Exception ex)
            {
                Alert("alert-danger", ex.Message);
            }
        }

        protected void Remover_Click(object sender, EventArgs e)
        {
            List<int> ids = ObtersIdsCarrinhoItemSelecionados();

            string item = OrigemSams() ? "item" : "produto";
            string itens = OrigemSams() ? "itens" : "produtos";

            if (ids.Count == 0)
            {
                Alert("alert-warning", $"Nenhum { item } selecionado.");
            }
            else if (ids.Count == GridItens.Rows.Count)
            {
                RemoverMsg.Text = $"Deseja remover todos os { itens } do carrinho?";
                ModalRemover.Visible = true;
            }
            else
            {
                RemoverMsg.Text = $"Deseja remover os { itens } selecionados do carrinho?";
                ModalRemover.Visible = true;
            }
        }

        private List<int> ObtersIdsCarrinhoItemSelecionados()
        {
            List<int> ids = new List<int>();

            GridView grid = OrigemSams() ? GridItens : GridProdutos;
            foreach (GridViewRow row in grid.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox selecionado = row.FindControl("Selecionado") as CheckBox;
                    if (selecionado.Checked)
                    {
                        HiddenField idCarrinhoItem = row.FindControl("IdCarrinhoItem") as HiddenField;
                        ids.Add(int.Parse(idCarrinhoItem.Value));
                    }
                }
            }
            return ids;
        }

        protected bool OrigemSams()
        {
            int idCarrinho = int.Parse(Carrinhos.SelectedValue);
            return idCarrinho == 0 || !Carrinhos.SelectedItem.Text.Contains("Produto");
        }

        protected void AlternarSelecao_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox alternarSelecao = sender as CheckBox;
            GridView grid = alternarSelecao.Parent.Parent.Parent.Parent as GridView;
            foreach (GridViewRow row in grid.Rows)
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

            GridView grid = OrigemSams() ? GridItens : GridProdutos;
            if (ids.Count == grid.Rows.Count)
            {
                PreencherCarrinhos();
            }
            else
            {
                string idCarrinho = Carrinhos.SelectedValue;
                PreencherCarrinhos();
                ListItem listItem = Carrinhos.Items.FindByValue(idCarrinho);
                Carrinhos.SelectedValue = idCarrinho;
                ApresentarCarrinho();
            }

            ModalRemover.Visible = false;
            Alert("alert-success", OrigemSams() ? "Itens Removidos." : "Produtos Removidos.");

        }

        protected void CancelarRemover_Click(object sender, EventArgs e)
        {
            ModalRemover.Visible = false;
            Alert("alert-info", OrigemSams() ? "Os itens não foram removidos." : "Os produtos não foram removidos.");
        }

        protected void Alert(string alertType, string alertMsg)
        {
            AlertType.Value = alertType;
            AlertMsg.Value = alertMsg;
        }
    }
}