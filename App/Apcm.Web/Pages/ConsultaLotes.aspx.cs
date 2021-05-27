using Apcm.Service.Lote;
using Apcm.Web.Pages.Layout;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Apcm.Web.Pages
{
    public partial class ConsultaLotes : AppPage
    {

        private const string sessionFiltro = "ConsultaLotes_Filtro";
        protected FiltroConsultaLote Filtro { get { return Session[sessionFiltro] as FiltroConsultaLote; } set { Session[sessionFiltro] = value; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            Alert(string.Empty, string.Empty);
            iFrameDownload.Src = string.Empty;

            if (IsPostBack)
            {
                return;
            }

            ValidarAcesso();
            ObterStatusItem();
            ItensLocalizados.Text = "0";

            DefinirCodOrigem();

            if (!string.IsNullOrEmpty(PageParameters.LoteInicial))
            {
                NumeroLote.Text = PageParameters.LoteInicial;
                Pesquisar_Click(sender, e);
                Alert("alert-success", $"Lote {PageParameters.LoteInicial} gerado com sucesso.");
                PageParameters.LoteInicial = string.Empty;
            }
        }

        private void DefinirCodOrigem()
        {
            if (!string.IsNullOrEmpty(PageParameters.CodOrigem))
            {
                if (PageParameters.CodOrigem == "Novo")
                {
                    CodOrigem.SelectedValue = "Novo";
                    CodOrigem.Enabled = false;
                }
            }
        }

        private void ObterDatas(out DateTime? dataDe, out DateTime? dataAte)
        {
            DateTime? getDate(string date) =>
                DateTime.TryParse(date, new CultureInfo("pt-BR"), DateTimeStyles.None, out DateTime dateResut) ?
                new Nullable<DateTime>(dateResut) :
                new Nullable<DateTime>();

            dataDe = getDate(DataDe.Text);
            dataAte = getDate(DataAte.Text);
        }

        protected void Pesquisar_Click(object sender, EventArgs e)
        {
            ObterDatas(out DateTime? dataDe, out DateTime? dataAte);
            if ((dataDe.HasValue && !dataAte.HasValue) || (!dataDe.HasValue && dataAte.HasValue) || (dataDe.HasValue && dataAte.HasValue && dataDe.Value > dataAte.Value))
            {
                Alert("alert-warning", "O período informado é inválido");
                return;
            }

            Filtro = new FiltroConsultaLote
            {
                Usuario = Usuario.Text,
                NumeroLote = NumeroLote.Text,
                CodOrigem = CodOrigem.SelectedValue,
                DataDe = dataDe,
                DataAte = dataAte,
                StatusLote = int.Parse(StatusLote.SelectedValue),
                StatusItem = StatusItem.SelectedValue
            };

            List<RetornoPesquisaLote> retorno = Services.LoteService.ConsultaLote(Filtro, out int qtdRegistros);
            ItensLocalizados.Text = string.Format(qtdRegistros > 1000 ? "{0:N0} (exibindo os primeiros 1.000 registros)" : "{0:N0}", qtdRegistros);

            GridLote.DataSource = retorno;
            GridLote.DataBind();

            if (GridLote.Rows.Count > 0)
            {
                Exportar.Enabled = true;
            }
            else
            {
                Alert("alert-warning", "Nenhum registro localizado.");
            }
        }

        protected void Limpar_Click(object sender, EventArgs e)
        {
            Filtro = null;
            Usuario.Text = string.Empty;
            NumeroLote.Text = string.Empty;

            CodOrigem.SelectedIndex = 0;
            DefinirCodOrigem();
            DataDe.Text = string.Empty;
            DataAte.Text = string.Empty;

            ObterStatusItem();
            StatusLote.SelectedIndex = 0;
            StatusLote_TextChanged(sender, e);

            GridLote.DataSource = new List<RetornoPesquisaLote>();
            GridLote.DataBind();

            ItensLocalizados.Text = "0";

            Exportar.Enabled = false;
        }

        protected void Exportar_Click(object sender, EventArgs e)
        {
            if (Filtro == null)
            {
                return;
            }

            FileInfo outputFile = Services.LoteService.ConsultaLoteExportacao(Filtro, MapPath(Properties.Settings.Default.filesVirtualPath));
            string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, outputFile.Name);
            string downloadPath = ResolveUrl(downloadVirtualPath);
            iFrameDownload.Src = downloadPath;
            Alert("alert-success", string.Format("O arquivo {0} foi exportado com sucesso.", outputFile.Name));
        }

        protected void StatusLote_TextChanged(object sender, EventArgs e)
        {
            if (StatusLote.SelectedValue == "0")
            {
                StatusItem.SelectedIndex = 0;
                StatusItem.Enabled = false;
            }
            else
            {
                StatusItem.Enabled = true;
            }
        }

        private void ObterStatusItem()
        {
            ObterDatas(out DateTime? dataDe, out DateTime? dataAte);
            if (!dataDe.HasValue || !dataAte.HasValue)
            {
                dataDe = new Nullable<DateTime>();
                dataAte = new Nullable<DateTime>();
            }

            StatusItem.DataSource = Services.LoteService.ObterStatusItem(CodOrigem.SelectedValue, dataDe, dataAte);
            StatusItem.DataBind();
        }

        private void Alert(string alertType, string alertMsg)
        {
            AlertType.Value = alertType;
            AlertMsg.Value = alertMsg;
        }

        protected void CodOrigem_TextChanged(object sender, EventArgs e)
        {
            ObterStatusItem();
        }

        protected void DataDe_TextChanged(object sender, EventArgs e)
        {
            ObterStatusItem();
        }

        protected void DataAte_TextChanged(object sender, EventArgs e)
        {
            ObterStatusItem();
        }
    }
}