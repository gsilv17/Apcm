using Apcm.Service.Carrinho;
using Apcm.Service.Sad;
using Apcm.Web.Pages.Layout;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Apcm.Web.Pages
{
    public partial class PesquisaProdutos : AppPage
    {

        private const string sessionProdutosPesquisaJSon = "PesquisaProdutos_ProdutosPesquisaJSon";
        private const string sessionProdutosCarrinhoJSon = "PesquisaProdutos_ProdutosCarrinhoJSon";
        protected List<ProdutoData> ProdutosPesquisa { get { return Session[sessionProdutosPesquisaJSon] as List<ProdutoData>; } set { Session[sessionProdutosPesquisaJSon] = value; } }
        protected List<ProdutoData> ProdutosCarrinho { get { return Session[sessionProdutosCarrinhoJSon] as List<ProdutoData>; } set { Session[sessionProdutosCarrinhoJSon] = value; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            Alert(string.Empty, string.Empty);

            if (IsPostBack)
            {
                return;
            }

            ValidarAcesso();
            CarregarSecao(sender, e);
            DefinirFinalizar();
            PageTitle.Text = string.Format("Pesquisa de Produtos - {0}", SistemaAtacado() ? "Sam's" : "Varejo");
        }

        private void DefinirFinalizar()
        {
            Finalizar.Disabled = GridCarrinho.Rows.Count == 0 || GridCarrinho.Rows.Count > 1000;
            Finalizar.Attributes["class"] = string.Format("btn btn-sm text-truncate w-100 dropdown-toggle {0}", Finalizar.Disabled ? "btn-danger disabled" : "btn-success");

        }

        protected void CarregarSecao(object sender, EventArgs e)
        {
            Secao.DataSource = AddAll(Services.EstruturaMercadologica.ObterSecoes(PageParameters.CodSistema));
            Secao.DataBind();
            Linha.Enabled = false;
            Sublinha.Enabled = false;
        }

        protected void CarregarLinha(object sender, EventArgs e)
        {
            int.TryParse(Secao.SelectedValue, out int secao);
            Linha.DataSource = secao > 0 ? AddAll(Services.EstruturaMercadologica.ObterLinhas(PageParameters.CodSistema, secao)) : new Dictionary<int, string>();
            Linha.DataBind();
            Linha.Enabled = secao > 0;
            CarregarSublinha(sender, e);
        }

        protected void CarregarSublinha(object sender, EventArgs e)
        {
            int.TryParse(Secao.SelectedValue, out int secao);
            int.TryParse(Linha.SelectedValue, out int linha);
            Sublinha.DataSource = linha > 0 ? AddAll(Services.EstruturaMercadologica.ObterSublinhas(PageParameters.CodSistema, secao, linha)) : new Dictionary<int, string>();
            Sublinha.DataBind();
            Sublinha.Enabled = linha > 0;
        }

        private Dictionary<int, string> AddAll(Dictionary<int, string> dic)
        {
            return (new Dictionary<int, string>() { { -1, "Todas" } }).Concat(dic).ToDictionary(k => k.Key, v => v.Value);
        }

        protected void Pesquisar_Click(object sender, EventArgs e)
        {
            bool isNumeric(string s) { return long.TryParse(s, out long i); }
            int toInt(string s) { return int.TryParse(s, out int i) ? i : -1; }

            int secao = toInt(Secao.SelectedValue);
            int linha = toInt(Linha.SelectedValue);
            int sublinha = toInt(Sublinha.SelectedValue);

            List<long> itens = Itens.Text
                .Replace("\n", " ")
                .Replace(",", " ")
                .Replace(";", " ")
                .Replace("|", " ")
                .Split(' ')
                .Distinct()
                .Where(i => isNumeric(i))
                .Select(i => long.Parse(i))
                .Where(i => i > 0)
                .ToList();

            if ((secao <= 0 || linha <= 0) && itens.Count == 0)
            {
                Alert("alert-warning", "Informe um produto ou uma Seção e Linha para realizar a pesquisa.");
                return;
            }

            List<ProdutoData> produtos;

            try
            {
                produtos = Services.Carrinho.PesquisarProdutos(itens, secao, linha, sublinha, PageParameters.CodSistema);
                if (produtos.Count == 0)
                {
                    Alert("alert-warning", "Nenhum produto foi localizado.");
                }
                else
                {
                    ProdutosPesquisa = ClonarJSon(produtos);
                }
            }
            catch (Exception ex)
            {
                produtos = new List<ProdutoData>();
                ProdutosPesquisa = produtos;
                Alert("Alert-danger", $"Falha ao pesquisar produtos: {ex.Message}");
            }

            GridPesquisa.DataSource = produtos;
            GridPesquisa.DataBind();

            if (GridPesquisa.Rows.Count > 0)
            {
                RealizarInclusao(false);
            }
        }

        protected void Limpar_Click(object sender, EventArgs e)
        {
            Itens.Text = string.Empty;
            CarregarSecao(sender, e);
            CarregarLinha(sender, e);
            CarregarSublinha(sender, e);
            GridPesquisa.DataSource = new List<ProdutoData>();
            GridPesquisa.DataBind();
            GridCarrinho.DataSource = new List<ProdutoData>();
            GridCarrinho.DataBind();
            ProdutosPesquisa = new List<ProdutoData>();
            ProdutosCarrinho = new List<ProdutoData>();
            DefinirFinalizar();
        }

        protected void Alert(string alertType, string alertMsg)
        {
            AlertType.Value = alertType;
            AlertMsg.Value = alertMsg;
        }

        protected void CarrinhoProdutoGrid_Click(object sender, EventArgs e)
        {
            FinalizarCarrinho(somenteGrid: false);
        }

        protected void CarrinhoGrid_Click(object sender, EventArgs e)
        {
            FinalizarCarrinho(somenteGrid: true);
        }

        protected void FinalizarCarrinho(bool somenteGrid)
        {
            List<ProdutoData> produtosCarrinho = GridToProdutos(GridCarrinho).ToList();

            if (produtosCarrinho.Count == 0)
            {
                return;
            }

            int idCarrinho = Services.Carrinho.CriarCarrinhoSad(produtosCarrinho, AppUser, somenteGrid, PageParameters.CodSistema);

            AlertMsg.Value = "Carrinho criado com sucesso!";
            AlertType.Value = "alert-success";
            Limpar_Click(null, null);

            PageParameters.IdCarrinhoInicial = idCarrinho;
            PageParameters.CodOrigem = "Sad";
            Response.Redirect("~/Carrinho");
        }

        protected void AlternarSelecionado_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = (CheckBox)sender;
            GridView grid = (GridView)checkBox.Parent.Parent.Parent.Parent;
            foreach (GridViewRow row in grid.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox selecionado = (CheckBox)row.Cells[0].FindControl("Selecionado");
                    selecionado.Checked = checkBox.Checked;
                }
            }
        }

        protected void Incluir_Click(object sender, EventArgs e)
        {
            RealizarInclusao(true);
        }

        private void RealizarInclusao(bool somenteSelecionados)
        {
            List<ProdutoData> produtosPesquisa = GridToProdutos(GridPesquisa).ToList();
            List<ProdutoData> produtosCarrinho = GridToProdutos(GridCarrinho).ToList();
            produtosCarrinho.AddRange(produtosPesquisa.Where(pp => (!somenteSelecionados || somenteSelecionados && pp.Selecionado) && !produtosCarrinho.Any(pc => pc.CodProd == pp.CodProd)));
            produtosCarrinho.ForEach(p => p.Selecionado = false);

            if (produtosCarrinho.Count > 1000)
            {
                produtosCarrinho = produtosCarrinho.Take(1000).ToList();
                Alert("alert-warning", "Limite de 1.000 produtos atingido, alguns produtos selecionados não foram incluídos.");
            }

            ProdutosCarrinho = ClonarJSon(produtosCarrinho);

            GridCarrinho.DataSource = produtosCarrinho;
            GridCarrinho.DataBind();

            DefinirFinalizar();
        }

        protected IEnumerable<ProdutoData> GridToProdutos(GridView grid)
        {
            foreach (GridViewRow row in grid.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow && row.Cells[0].FindControl("Selecionado") is CheckBox selecionado)
                {
                    string codProd = row.Cells[1].Text;
                    ProdutoData produtoFiltro = ProdutosPesquisa.FirstOrDefault(p => p.CodProd == codProd);
                    ProdutoData filtro = produtoFiltro == null ? ProdutosCarrinho.FirstOrDefault(p => p.CodProd == codProd) : produtoFiltro;
                    if (filtro != null)
                    {
                        ProdutoData produto = new ProdutoData();
                        string produtoJSon = filtro.ProdutoJSon;
                        produto.DefinirProduto(produtoJSon);

                        produto.Selecionado = selecionado.Checked;
                        selecionado.Checked = false;

                        produto.Basico.SecaoDesc = HttpUtility.HtmlDecode(row.Cells[4].Text);
                        produto.Basico.LinhaDesc = HttpUtility.HtmlDecode(row.Cells[6].Text);
                        produto.Basico.SlinhaDesc = HttpUtility.HtmlDecode(row.Cells[8].Text);

                        yield return produto;
                    }
                }
            }
        }

        protected void Remover_Click(object sender, EventArgs e)
        {
            List<ProdutoData> produtosCarrinho = GridToProdutos(GridCarrinho).ToList();
            produtosCarrinho.RemoveAll(p => p.Selecionado);
            ProdutosCarrinho = ClonarJSon(produtosCarrinho);
            GridCarrinho.DataSource = produtosCarrinho;
            GridCarrinho.DataBind();
            DefinirFinalizar();
        }

        private List<ProdutoData> ClonarJSon(List<ProdutoData> origem)
        {
            List<ProdutoData> pCopia = new List<ProdutoData>();
            origem.ForEach((Action<ProdutoData>)(p =>
            {
                pCopia.Add(new ProdutoData { CodProd = p.CodProd, ProdutoJSon = p.ProdutoJSon });
                p.ProdutoJSon = string.Empty;
            }));

            return pCopia;
        }
    }
}