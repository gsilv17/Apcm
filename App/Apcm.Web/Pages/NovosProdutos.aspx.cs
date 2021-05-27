using Apcm.Service.Carrinho;
using Apcm.Web.Pages.Layout;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Apcm.Web.Pages
{
    public partial class NovosProdutos : AppPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Alert(string.Empty, string.Empty);

            fileUpXlsLabel.Text = "Selecione um arquivo...";

            if (IsPostBack)
            {
                return;
            }

            ValidarAcesso();

            FileUpXls.Attributes.Add("aria-describedby", Importar.ClientID);
        }

        protected void Importar_Click(object sender, EventArgs e)
        {
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
                    AppUser.Login,
                    MapPath(Properties.Settings.Default.filesVirtualPath),
                    PageParameters.CodSistema);

                if(result.PodeEnviar)
                {
                    string lote = Services.Carrinho.Enviar(result.IdCarrinho);
                    PageParameters.LoteInicial = lote;
                    PageParameters.CodOrigem = "Novo";
                    Response.Redirect("~/ConsultaLotes");
                } 
                else
                {
                    iFrameDownload.Src = string.Empty;
                    if (result.OutputFile != null)
                    {
                        string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, result.OutputFile.Name);
                        string downloadPath = ResolveUrl(downloadVirtualPath);
                        iFrameDownload.Src = downloadPath;
                    }

                    Alert(result.AlertType, result.AlertMsg);
                }

                
            }
            catch (Exception ex)
            {
                Alert("alert-warning", ex.Message);
            }
        }

        protected void Exportar_Click(object sender, EventArgs e)
        {
            FileInfo outputFile = Services.Carrinho.Exportar(MapPath(Properties.Settings.Default.filesVirtualPath));
            string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, outputFile.Name);
            string downloadPath = ResolveUrl(downloadVirtualPath);
            iFrameDownload.Src = downloadPath;
            Alert("alert-success", string.Format("O arquivo {0} foi exportado com sucesso.", outputFile.Name));
        }

        protected void Alert(string alertType, string alertMsg)
        {
            AlertType.Value = alertType;
            AlertMsg.Value = alertMsg;
        }
    }
}