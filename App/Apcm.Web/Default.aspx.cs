using System;
using System.Globalization;
using System.IO;
using Apcm.Service.Carrinho;
using Apcm.Service.Data;
using Apcm.Web.Pages.Layout;

namespace Apcm.Web
{
    public partial class Default : AppPage
    {

        protected static string AppVersion { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            PreencherVersao();
            PreencherCards();
            iFrameDownload.Src = string.Empty;
        }

        private void PreencherVersao()
        {
            if (string.IsNullOrEmpty(AppVersion))
            {
                FileInfo fileInfo = new FileInfo(this.GetType().Assembly.Location);
                AppVersion = string.Format("v.{0:ddMMyy}.{0:HHmm}", fileInfo.CreationTime);
            }

            Versao.Text = AppVersion;
        }

        private void PreencherCards()
        {
            if (!AppUser.Admin && !AppUser.Editor)
            {
                dvSemPerfil.Visible = true;
                dvCard.Visible = false;
                return;
            }

            dvSemPerfil.Visible = false;
            dvCard.Visible = true;

            IFormatProvider ptBR = new CultureInfo("pt-br");
            ContagemCardHome contagem = Services.Carrinho.ObterContagemCardHome();
            
            //CardComCrossPecent.Text = $"{contagem.PercentComDexPara.ToString("N2", ptBR)}%";
            //CardComCrossQtd.Text =
            //    contagem.QtdComDexPara == contagem.QtdItens ?
            //    $"Todos os {contagem.QtdItens.ToString("N0", ptBR)} itens possuem Cross." :
            //    contagem.QtdComDexPara == 0 ?
            //    $"Nenhum dos {contagem.QtdItens.ToString("N0", ptBR)} itens possuem Cross." :
            //    $"{contagem.QtdComDexPara.ToString("N0", ptBR)} itens com Cross de um total de {contagem.QtdItens.ToString("N0", ptBR)} na base.";
            
            //CardCrossPercent.Text = $"{contagem.PercentSemDexPara.ToString("N2", ptBR)}%";
            //CardCrossQtd.Text =
            //    contagem.QtdSemDexPara == contagem.QtdItens ?
            //    $"Nenhum dos {contagem.QtdItens.ToString("N0", ptBR)} itens possui De x Para." :
            //    contagem.QtdSemDexPara == 0 ?
            //    $"Todos os {contagem.QtdItens.ToString("N0", ptBR)} itens possuem Cross." :
            //    $"{contagem.QtdSemDexPara.ToString("N0", ptBR)} itens sem Cross de um total de {contagem.QtdItens.ToString("N0", ptBR)} na base.";

            CardProcessamentoSadPercent.Text = $"{contagem.PercentRetornoErroSad.ToString("N2", ptBR)}%";
            CardProcessamentoSadQtd.Text =
                contagem.QtdRetornoErroSad == contagem.QtdRetornoSad && contagem.QtdRetornoSad > 0 ?
                $"Todos os {contagem.QtdRetornoSad.ToString("N0", ptBR)} retornos possuem erro de processamento." :
                contagem.QtdRetornoErroSad == 0 ?
                $"Nenhum dos {contagem.QtdRetornoSad.ToString("N0", ptBR)} retornos possui erro de processamento." :
                $"{contagem.QtdRetornoErroSad.ToString("N0", ptBR)} retornos possuem erro de um total de {contagem.QtdRetornoSad.ToString("N0", ptBR)} processamentos.";

            //CardCarrinhosPercent.Text = $"{contagem.PercentCarrinhoItensErro.ToString("N2", ptBR)}%";
            //CardCarrinhosQtd.Text =
            //    contagem.QtdCarrinhoItens == contagem.QtdCarrinhoItensErro && contagem.QtdCarrinhoItens > 0 ?
            //    $"Todos os {contagem.QtdCarrinhoItens.ToString("N0", ptBR)} itens possuem crítica de validação." :
            //    contagem.QtdCarrinhoItensErro == 0 ?
            //    $"Nenhum dos {contagem.QtdCarrinhoItens.ToString("N0", ptBR)} itens possuem crítica de validação." :
            //    $"{contagem.QtdCarrinhoItensErro.ToString("N0", ptBR)} itens possuem crítica de validação, de um total de {contagem.QtdCarrinhoItens.ToString("N0", ptBR)}.";

            //DownloadCross.Enabled = contagem.QtdSemDexPara > 0;
            //DownloadComCross.Enabled = contagem.QtdComDexPara > 0;
            DownloadErro.Enabled = contagem.QtdRetornoErroSad > 0;
            //DownloadCarrinho.Enabled = contagem.QtdCarrinhoItensErro > 0;

            //if (!DownloadCross.Enabled)
            //{
            //    DownloadCross.ImageUrl = DownloadCross.ImageUrl.Replace("download.svg", "downloadDisabled.svg");
            //}

            if (!DownloadErro.Enabled)
            {
                DownloadErro.ImageUrl = DownloadErro.ImageUrl.Replace("download.svg", "downloadDisabled.svg");
            }

            //if (!DownloadCarrinho.Enabled)
            //{
            //    DownloadCarrinho.ImageUrl = DownloadCarrinho.ImageUrl.Replace("download.svg", "downloadDisabled.svg");
            //}
        }

        protected void DownloadCross_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            FileInfo outputFile = Services.Carrinho.DownloadCardCross(MapPath(Properties.Settings.Default.filesVirtualPath));
            string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, outputFile.Name);
            string downloadPath = ResolveUrl(downloadVirtualPath);
            iFrameDownload.Src = downloadPath;
        }

        protected void DownloadErro_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            FileInfo outputFile = Services.Carrinho.DownloadCardErroRetorno(MapPath(Properties.Settings.Default.filesVirtualPath));
            string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, outputFile.Name);
            string downloadPath = ResolveUrl(downloadVirtualPath);
            iFrameDownload.Src = downloadPath;
        }

        protected void DownloadCarrinho_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            FileInfo outputFile = Services.Carrinho.DownloadCardCarrinho(MapPath(Properties.Settings.Default.filesVirtualPath));
            string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, outputFile.Name);
            string downloadPath = ResolveUrl(downloadVirtualPath);
            iFrameDownload.Src = downloadPath;
        }

        protected void DownloadComCross_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            FileInfo outputFile = Services.Carrinho.DownloadCardComCross(MapPath(Properties.Settings.Default.filesVirtualPath));
            string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, outputFile.Name);
            string downloadPath = ResolveUrl(downloadVirtualPath);
            iFrameDownload.Src = downloadPath;
        }
    }
}