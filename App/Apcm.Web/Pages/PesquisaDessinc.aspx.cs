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
    public partial class PesquisaDessinc : AppPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DefinirAlerta(AlertType, AlertMsg);

            if (IsPostBack)
            {
                return;
            }

            ValidarAdmin();
            ProdutoNbr.Focus();

            Response.Redirect("~/Default.aspx");
        }
        
        protected void Pesquisar_Click(object sender, EventArgs e)
        {
            int? produtoNbr = ObterNbr(ProdutoNbr.Text);
            int? itemNbr = ObterNbr(ItemNbr.Text);

            if (!produtoNbr.HasValue && !itemNbr.HasValue)
            {
                AlertInfo("Informe o Produto ou o Item.");
                return;
            }

            List<DessincPesquisaData> itens = Services.CrossService.PesquisaDessinc(produtoNbr, itemNbr);
            if (itens.Count == 0)
            {
                AlertInfo("Nenhum registro localizado.");
            }
            
            GridPesquisa.DataSource = itens;
            GridPesquisa.DataBind();
        }

        private static int? ObterNbr(string nbr)
        {
            return int.TryParse(nbr, out int result) ? new int?(result) : new int?();
        }

        protected void Limpar_Click(object sender, EventArgs e)
        {
            ProdutoNbr.Text = string.Empty;
            ProdutoNbr.Focus();
            ItemNbr.Text = string.Empty;
            GridPesquisa.DataSource = new List<DessincPesquisaData>();
            GridPesquisa.DataBind();
        }
    }
}