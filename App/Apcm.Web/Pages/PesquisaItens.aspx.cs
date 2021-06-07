using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
using Apcm.Service.Carrinho;
using Apcm.Service.EstruturaMercadologica;
using Apcm.Service.Item;
using Apcm.Web.Pages.Layout;
using Apcm.Web.Properties;

namespace Apcm.Web.Pages
{
    public partial class PesquisaItens : AppPage
    {
        private const string sessionPrateleira = "PesquisaItens_SessionPrateleira";
        private const string sessionCarrinho = "PesquisaItens_SessionCarrinho";
        private const string sessionCategorias = "PesquisaItens_SessionCategorias";
        private const string sessionSubcategorias = "PesquisaItens_SessionSubcategorias";
        private const string sessionFinelines = "PesquisaItens_SessionFinelines";

        private IEstruturaMercadologicaService EstruturaMercadologicaService => Services.EstruturaMercadologica;
        private ICarrinhoService CarrinhoService => Services.Carrinho;
        protected List<PesquisaPrateleiraResultado> ItensPrateleira { get; set; }
        protected List<PesquisaPrateleiraResultado> ItensCarrinho { get; set; }
        protected List<EstruturaMercadologicaSamsData> Categorias { get { return Session[sessionCategorias] is List<EstruturaMercadologicaSamsData> e ? e : new List<EstruturaMercadologicaSamsData>(); } set { Session[sessionCategorias] = value; } }
        protected List<EstruturaMercadologicaSamsData> Subcategorias { get { return Session[sessionSubcategorias] is List<EstruturaMercadologicaSamsData> e ? e : new List<EstruturaMercadologicaSamsData>(); } set { Session[sessionSubcategorias] = value; } }
        protected List<EstruturaMercadologicaSamsData> Finelines { get { return Session[sessionFinelines] is List<EstruturaMercadologicaSamsData> e ? e : new List<EstruturaMercadologicaSamsData>(); } set { Session[sessionFinelines] = value; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            AlertMsg.Value = string.Empty;

            if (IsPostBack)
            {
                return;
            }
                        
            ValidarEditorOuAdmin();

            SessionItensPrateleira(AcaoSession.Limpar);
            SessionItensCarrinho(AcaoSession.Limpar);
            ItensLocalizados.Text = "0";
            CarregarCarrinho();

            Response.Redirect("~/Default.aspx");
        }

        private void SessionItensCarrinho(AcaoSession acao)
        {
            switch (acao)
            {
                case AcaoSession.Armazenar:
                    Session[sessionCarrinho] = ItensCarrinho;
                    break;
                case AcaoSession.Recuperar:
                    ItensCarrinho = Session[sessionCarrinho] == null ? new List<PesquisaPrateleiraResultado>() : Session[sessionCarrinho] as List<PesquisaPrateleiraResultado>;
                    break;
                case AcaoSession.Limpar:
                    Session[sessionCarrinho] = null;
                    ItensCarrinho = new List<PesquisaPrateleiraResultado>();
                    break;
                default:
                    break;
            }
        }

        private void SessionItensPrateleira(AcaoSession acao)
        {
            switch (acao)
            {
                case AcaoSession.Armazenar:
                    Session[sessionPrateleira] = ItensPrateleira;
                    break;
                case AcaoSession.Recuperar:
                    ItensPrateleira = Session[sessionPrateleira] == null ? new List<PesquisaPrateleiraResultado>() : Session[sessionPrateleira] as List<PesquisaPrateleiraResultado>;
                    break;
                case AcaoSession.Limpar:
                    Session[sessionPrateleira] = null;
                    ItensPrateleira = new List<PesquisaPrateleiraResultado>();
                    break;
                default:
                    break;
            }
        }

        private Dictionary<int, string> AddAll(Dictionary<int, string> dic)
        {
            return (new Dictionary<int, string>() { { -1, "Todas" } }).Concat(dic).ToDictionary(k => k.Key, v => v.Value);
        }

        private void CarregarCarrinho()
        {
            SessionItensCarrinho(AcaoSession.Recuperar);
            GridCarrinho.DataSource = ItensCarrinho;
            GridCarrinho.DataBind();

            Finalizar.Disabled = GridCarrinho.Rows.Count == 0 || GridCarrinho.Rows.Count > 1000;
            Finalizar.Attributes["class"] = string.Format("btn btn-sm text-truncate w-100 dropdown-toggle {0}", Finalizar.Disabled ? "btn-danger disabled" : "btn-success");
        }

        protected void Pesquisar_Click(object sender, EventArgs e)
        {

            bool isNumeric(string s) { return long.TryParse(s, out long i); }
            int toInt(string s) { return int.TryParse(s, out int i) ? i : -1; }

            List<EstruturaMercadologicaSamsData> estruturaLocal = new List<EstruturaMercadologicaSamsData>();
            estruturaLocal.AddRange(Finelines);
            estruturaLocal.AddRange(Subcategorias.Where(s => !Finelines.Any(f => f.CodCategoria == s.CodCategoria && f.CodSubcategoria == s.CodSubcategoria)));
            estruturaLocal.AddRange(Categorias.Where(c => !Finelines.Any(f => f.CodCategoria == c.CodCategoria) && !Subcategorias.Any(s => s.CodCategoria == c.CodCategoria)));
            List<PesquisaPrateleiraFiltroEstrutura> filtroEstrutura = new List<PesquisaPrateleiraFiltroEstrutura>();
            estruturaLocal.ForEach(est => filtroEstrutura.Add(new PesquisaPrateleiraFiltroEstrutura
            {
                CodCategoria = est.CodCategoria,
                CodSubcategoria = est.CodSubcategoria ?? -1,
                CodFineline = est.CodFineline ?? -1
            }));

            PesquisaPrateleiraFiltro filtro = new PesquisaPrateleiraFiltro
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
                Fornecedores = Fornecedores.Text
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
                PossuiCross = toInt(PossuiCross.SelectedValue),
                EmEdicao = toInt(EmEdicao.SelectedValue),
                Estrutura = filtroEstrutura
            };

            ItensPrateleira = Services.Item.PesquisaPrateleira(filtro, out int qtdRegistros);
            ItensLocalizados.Text = string.Format(qtdRegistros > 1000 ? "{0:N0} (exibindo os primeiros 1.000 registros)" : "{0:N0}", qtdRegistros);

            SessionItensPrateleira(AcaoSession.Armazenar);
            GridPesquisa.DataSource = ItensPrateleira;
            GridPesquisa.DataBind();

            if (ItensPrateleira.Count == 0)
            {
                AlertMsg.Value = "Nenhum registro localizado!";
                AlertType.Value = "alert-warning";
            }
            else
            {
                RealizarInclusao(false);
            }
        }

        protected void Limpar_Click(object sender, EventArgs e)
        {
            Itens.Text = string.Empty;
            Fornecedores.Text = string.Empty;

            Categorias = new List<EstruturaMercadologicaSamsData>();
            Subcategorias = new List<EstruturaMercadologicaSamsData>();
            Finelines = new List<EstruturaMercadologicaSamsData>();
            CategoriaDesc.Text = "Todas";
            SubcategoriaDesc.Text = "Todas";
            FinelineDesc.Text = "Todas";

            PossuiCross.SelectedIndex = 0;
            EmEdicao.SelectedIndex = 0;

            SessionItensCarrinho(AcaoSession.Limpar);
            SessionItensPrateleira(AcaoSession.Limpar);
            GridPesquisa.DataSource = null;
            GridCarrinho.DataSource = null;
            GridPesquisa.DataBind();
            GridCarrinho.DataBind();
            ItensLocalizados.Text = "0";
        }

        protected void Incluir_Click(object sender, EventArgs e)
        {
            RealizarInclusao(true);
        }

        private void RealizarInclusao(bool somenteSelecionados)
        {
            SessionItensCarrinho(AcaoSession.Recuperar);
            SessionItensPrateleira(AcaoSession.Recuperar);

            foreach (GridViewRow row in GridPesquisa.Rows)
            {
                if (
                    row.RowType == DataControlRowType.DataRow
                    && row.Cells[0].FindControl("Selecionado") is CheckBox selecionado
                    && row.Cells[0].FindControl("PodeSelecionar") is HiddenField podeSelecionar
                    && (Convert.ToBoolean(podeSelecionar.Value) || AppUser.Admin)
                    && (!somenteSelecionados || (somenteSelecionados && selecionado.Checked))
                    && int.TryParse(row.Cells[1].Text, out int item_nbr)
                    && !ItensCarrinho.Any(i => i.item_nbr == item_nbr))
                {
                    PesquisaPrateleiraResultado itemSelecionado = ItensPrateleira.Single(i => i.item_nbr == item_nbr);
                    itemSelecionado.Selecionado = false;
                    ItensCarrinho.Add(itemSelecionado);
                }
            }

            if (ItensCarrinho.Count > 1000)
            {
                ItensCarrinho = ItensCarrinho.Take(1000).ToList();
                AlertType.Value = "alert-warning";
                AlertMsg.Value = "Limite de 1.000 itens atingido, alguns itens selecionados não foram incluídos.";
            }

            SessionItensCarrinho(AcaoSession.Armazenar);
            CarregarCarrinho();
        }

        protected void Remover_Click(object sender, EventArgs e)
        {
            SessionItensCarrinho(AcaoSession.Recuperar);
            foreach (GridViewRow row in GridCarrinho.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox selecionado = (CheckBox)row.Cells[0].FindControl("Selecionado");
                    if (selecionado.Checked)
                    {
                        int item_nbr = Convert.ToInt32(row.Cells[1].Text);
                        ItensCarrinho.RemoveAll(i => i.item_nbr == item_nbr);
                    }
                }
            }

            SessionItensCarrinho(AcaoSession.Armazenar);
            CarregarCarrinho();
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

        protected void CarrinhoProdutoGrid_Click(object sender, EventArgs e)
        {
            GerarCarrinho(somenteGrid: false);
        }

        protected void CarrinhoGrid_Click(object sender, EventArgs e)
        {
            GerarCarrinho(somenteGrid: true);
        }

        protected void GerarCarrinho(bool somenteGrid)
        {
            SessionItensCarrinho(AcaoSession.Recuperar);
            if(AppUser.Admin && ItensCarrinho.Any(i => !i.PodeSelecionar))
            {
                int qtdEmUso = ItensCarrinho.Count(i => !i.PodeSelecionar);
                int qtdLivre = ItensCarrinho.Count(i => i.PodeSelecionar);
                ConfirmarCarrinhoParcial.Visible = qtdLivre > 0;
                SomenteGrid.Value = somenteGrid.ToString();
                ModalCarrinho.Visible = true;
                return;
            }

            ConfirmarCarrinho(somenteGrid: somenteGrid, cancelarEmEdicao: false);
        }

        protected void ConfirmarCarrinhoTotal_Click(object sender, EventArgs e)
        {
            ConfirmarCarrinho(Convert.ToBoolean(SomenteGrid.Value), cancelarEmEdicao: true);
        }

        protected void ConfirmarCarrinhoParcial_Click(object sender, EventArgs e)
        {
            ConfirmarCarrinho(Convert.ToBoolean(SomenteGrid.Value), cancelarEmEdicao: false);
        }

        protected void ConfirmarCarrinho(bool somenteGrid, bool cancelarEmEdicao)
        {
            SessionItensCarrinho(AcaoSession.Recuperar);
            //int idCarrinho = CarrinhoService.CriarCarrinhoSams(cancelarEmEdicao ? ItensCarrinho : ItensCarrinho.Where(i => !i.EmEdicao).ToList(), AppUser.Login, somenteGrid);
            int idCarrinho = 0; // Descontinuado.
            if (idCarrinho > 0)
            {
                AlertMsg.Value = "Carrinho criado com sucesso!";
                AlertType.Value = "alert-success";
                Limpar_Click(null, null);

                PageParameters.IdCarrinhoInicial = idCarrinho;
                PageParameters.CodOrigem = "Sams";
                Response.Redirect("~/Carrinho");
            }
            else
            {
                AlertMsg.Value = "Todos os itens informados já estão em edição em outros carrinhos, refaça sua pesquisa.";
                AlertType.Value = "alert-warning";
            }

            ModalCarrinho.Visible = false;
        }

     

        protected void CancelarCarrinho_Click(object sender, EventArgs e)
        {
            ModalCarrinho.Visible = false;
        }

        protected void ModalestruturaOk_Click(object sender, EventArgs e)
        {
            bool todosSelecionados = true;
            List<EstruturaMercadologicaSamsData> estrutura = new List<EstruturaMercadologicaSamsData>();
            foreach (GridViewRow row in GridEstrutura.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow
                    && (row.FindControl("Selecionado") is CheckBox selecionado)
                    && selecionado.Checked
                    && (row.FindControl("CodCategoria") is HiddenField codCategoria)
                    && (row.FindControl("CodSubcategoria") is HiddenField codSubcategoria)
                    && (row.FindControl("CodFineline") is HiddenField codFineline))
                {

                    if (int.TryParse(codCategoria.Value, out int codCat))
                    {
                        EstruturaMercadologicaSamsData ems = new EstruturaMercadologicaSamsData();
                        ems.CodCategoria = codCat;

                        if (int.TryParse(codSubcategoria.Value, out int codSub))
                        {
                            ems.CodSubcategoria = codSub;
                        }

                        if (int.TryParse(codFineline.Value, out int codFin))
                        {
                            ems.CodFineline = codFin;
                        }
                        estrutura.Add(ems);
                    }
                }
                else
                {
                    todosSelecionados = false;
                }
            }

            if (todosSelecionados)
            {
                estrutura = new List<EstruturaMercadologicaSamsData>();
            }

            string estruturaDesc = estrutura.Count == 0 ? "Todas" : estrutura.Count == 1 ? "1 Selecionada" : $"{estrutura.Count.ToString("N0", new CultureInfo("pt-br"))} Selecionadas";

            if (ModalEstruturaTitulo.Text == "Categorias")
            {
                Categorias = estrutura;
                CategoriaDesc.Text = estruturaDesc;

                SubcategoriaDesc.Text = "Todas";
                Subcategorias = new List<EstruturaMercadologicaSamsData>();

                FinelineDesc.Text = "Todas";
                Finelines = new List<EstruturaMercadologicaSamsData>();
            }
            else if (ModalEstruturaTitulo.Text == "Subcategorias")
            {
                Subcategorias = estrutura;
                SubcategoriaDesc.Text = estruturaDesc;

                FinelineDesc.Text = "Todas";
                Finelines = new List<EstruturaMercadologicaSamsData>();
            }
            else if (ModalEstruturaTitulo.Text == "Finelines")
            {
                Finelines = estrutura;
                FinelineDesc.Text = estruturaDesc;
            }

            GridEstrutura.DataSource = new List<EstruturaMercadologicaSamsData>();
            GridEstrutura.DataBind();

            ModalEstruturaTitulo.Text = "";
            ModalEstrutura.Visible = false;
        }

        protected void ModalEstruturaCancelar_Click(object sender, EventArgs e)
        {
            ModalEstrutura.Visible = false;
        }

        protected void AlternarSelecaoEstrutura_CheckedChanged(object sender, EventArgs e)
        {
            if (sender is CheckBox alternarSelecao)
            {
                foreach (GridViewRow row in GridEstrutura.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow && row.Visible && row.FindControl("Selecionado") is CheckBox selecionado)
                    {
                        selecionado.Checked = alternarSelecao.Checked;
                    }
                }
            }
        }

        protected void Categoria_ServerClick(object sender, EventArgs e)
        {
            for (int i = 0; i < GridEstrutura.Columns.Count; i++)
            {
                GridEstrutura.Columns[i].Visible = i < 3;
            }

            List<EstruturaMercadologicaSamsData> estrutura = Services.EstruturaMercadologica.ObterCategorias();
            Categorias.ForEach(c =>
                {
                    EstruturaMercadologicaSamsData em = estrutura.SingleOrDefault(selE => selE.CodCategoria == c.CodCategoria);
                    if (em != null)
                    {
                        em.Selecionado = true;
                    }
                });

            GridEstrutura.DataSource = estrutura;
            GridEstrutura.DataBind();
            ModalEstruturaTitulo.Text = "Categorias";
            FiltroEstrutura.Attributes.Remove("placeholder");
            FiltroEstrutura.Attributes.Add("placeholder", "Categorias (Cod. ou Nome)");
            ModalEstrutura.Visible = true;
        }

        protected void Subcategoria_ServerClick(object sender, EventArgs e)
        {
            for (int i = 0; i < GridEstrutura.Columns.Count; i++)
            {
                GridEstrutura.Columns[i].Visible = i < 5;
            }

            List<EstruturaMercadologicaSamsData> estrutura = Services.EstruturaMercadologica.ObterSubcategorias(Categorias);
            Subcategorias.ForEach(s =>
            {
                EstruturaMercadologicaSamsData em = estrutura.SingleOrDefault(selS => selS.CodCategoria == s.CodCategoria && selS.CodSubcategoria == s.CodSubcategoria);
                if (em != null)
                {
                    em.Selecionado = true;
                }
            });

            GridEstrutura.DataSource = estrutura;
            GridEstrutura.DataBind();
            ModalEstruturaTitulo.Text = "Subcategorias";
            FiltroEstrutura.Attributes.Remove("placeholder");
            FiltroEstrutura.Attributes.Add("placeholder", "Subcategorias (Cod. ou Nome)");
            ModalEstrutura.Visible = true;
        }

        protected void Fineline_ServerClick(object sender, EventArgs e)
        {
            for (int i = 0; i < GridEstrutura.Columns.Count; i++)
            {
                GridEstrutura.Columns[i].Visible = true;
            }

            List<EstruturaMercadologicaSamsData> estruturaLocal = new List<EstruturaMercadologicaSamsData>();
            estruturaLocal.AddRange(Subcategorias);
            estruturaLocal.AddRange(Categorias.Where(c => !Subcategorias.Any(s => s.CodCategoria == c.CodCategoria)));
            List<EstruturaMercadologicaSamsData> estrutura = Services.EstruturaMercadologica.ObterFinelines(estruturaLocal);
            Finelines.ForEach(f =>
            {
                EstruturaMercadologicaSamsData em = estrutura.SingleOrDefault(selF => selF.CodCategoria == f.CodCategoria && selF.CodSubcategoria == f.CodSubcategoria && selF.CodFineline == f.CodFineline);
                if (em != null)
                {
                    em.Selecionado = true;
                }
            });

            GridEstrutura.DataSource = estrutura;
            GridEstrutura.DataBind();
            ModalEstruturaTitulo.Text = "Finelines";
            FiltroEstrutura.Attributes.Remove("placeholder");
            FiltroEstrutura.Attributes.Add("placeholder", "Finelines (Cod. ou Nome)");
            ModalEstrutura.Visible = true;
        }

        protected void FiltrarEstrutura_Click(object sender, EventArgs e)
        {
            //string clear(string s) => Encoding.Default.GetString(Encoding.GetEncoding("iso-8859-7").GetBytes(s)).ToLower();
            string filtro = FiltroEstrutura.Text.ToLower();
            int colFiltro = ModalEstruturaTitulo.Text == "Categorias" ? 1 : ModalEstruturaTitulo.Text == "Subcategorias" ? 3 : 5;

            foreach (GridViewRow row in GridEstrutura.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    if (string.IsNullOrEmpty(filtro) || row.Cells[colFiltro].Text == filtro || HttpUtility.HtmlDecode(row.Cells[colFiltro + 1].Text).ToLower().Contains(filtro))
                    {
                        row.Visible = true;
                    }
                    else
                    {
                        if (row.FindControl("Selecionado") is CheckBox selecionado)
                        {
                            selecionado.Checked = false;
                        }
                        row.Visible = false;
                    }
                }
            }
        }

        protected void LimparFiltroEstrutura_Click(object sender, EventArgs e)
        {
            FiltroEstrutura.Text = string.Empty;
            FiltrarEstrutura_Click(sender, e);
        }

        
    }

    internal enum AcaoSession
    {
        Armazenar,
        Recuperar,
        Limpar
    }
}