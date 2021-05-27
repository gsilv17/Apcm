using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Apcm.Service.RetornoSAD;
using Apcm.Service.AppUser;
using Apcm.Web.Pages.Layout;

namespace Apcm.Web.Pages
{
    public partial class ConsultaRetornoSAD : AppPage
    {
        protected IResultSearch ResultSearch => Services.ResultSearch;

        protected void Page_Load(object sender, EventArgs e)
        {
            FecharModalAlerta(modalAlerta);

            if (IsPostBack)
            {
                return;
            }

            ddlStatusRetornoItem.DataSource = ResultSearch.PesquisarFiltroStatusRetorno();
            ddlStatusRetornoItem.DataTextField = "MENSAGEM";
            ddlStatusRetornoItem.DataValueField = "CODIGO";
            ddlStatusRetornoItem.DataBind();
            ValidarAcesso();
        }

        protected void Localizar(object sender, EventArgs e)
        {
            ExibirDados(ResultSearch.Pesquisar(Pesquisa.Text.Trim(), txtIdLote.Text.Trim(), ddlStatusRetornoItem.SelectedValue.Trim(), ddlStatusLote.SelectedValue));
        }

        private void ExibirDados(List<ResultSearchData> resultado)
        {
            GridView.DataSource = resultado;
            GridView.DataBind();
        }

        protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
         
        }

        protected void Exportar(object sender, EventArgs e)
        {
            FileInfo outputFile = ResultSearch.ExportarDados(Pesquisa.Text.Trim(), txtIdLote.Text.Trim(), MapPath(Properties.Settings.Default.filesVirtualPath), ddlStatusRetornoItem.SelectedValue.Trim(), ddlStatusLote.SelectedValue);
            string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, outputFile.Name);
            string downloadPath = ResolveUrl(downloadVirtualPath);
            iFrameDownload.Src = downloadPath;
        }



    }
}