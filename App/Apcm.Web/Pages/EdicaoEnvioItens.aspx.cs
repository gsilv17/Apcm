using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web.UI;
using System.Web.UI.WebControls;
using TSamsF3.Service.Carrinho;
using TSamsF3.Service.Extensions;
using TSamsF3.Service.Item;
using TSamsF3.Service.Sad;

namespace TSamsF3.Web.Pages
{
    public partial class EdicaoEnvioItens : TSamsF3Page
    {
        protected ICarrinhoSevice CarrinhoService => Services.Carrinho;
        //protected ISadService SadService => Services.Sad;
        public ItemData Modelo { get { return (ItemData)Session["EdicaoEnvioItens_Modelo"]; } set { Session["EdicaoEnvioItens_Modelo"] = value; } }
        public int IdCarrinho { get { return Convert.ToInt32(ViewState["EdicaoEnvioItens_IdCarrinho"]); } set { ViewState["EdicaoEnvioItens_IdCarrinho"] = value; } }
        public int ItemNbr { get { return Convert.ToInt32(ViewState["EdicaoEnvioItens_ItemNbr"]); } set { ViewState["EdicaoEnvioItens_ItemNbr"] = value; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            ValidarEditor();
            AlertMsg.Value = string.Empty;
            OcultarAlerta(ModalXls_Alert);
            iFrameDownload.Src = string.Empty;

            if (IsPostBack)
            {
                return;
            }

            if (Modelo == null)
            {
                Modelo = new ItemData();
            }

            //GridItens.DataSource = CarrinhoService.ObterEdicao(UserData.Login); ;
            //GridItens.DataBind();

            FileUpXls.Attributes.Add("aria-describedby", Importar.ClientID);
            //FileUpXls.Attributes.Add("onchange", string.Format("exibirNomeArquivo('{0}', '{1}')", FileUpXls.ClientID, "fileUpXlsLabel"));
        }

        protected void SalvarModelo_Click(object sender, EventArgs e)
        {
            //Page.Validate("vgModelo");
            //if (!Page.IsValid)
            //{
            //    return;
            //}

            //foreach (PropertyInfo propertyInfo in typeof(ItemData).GetProperties().Where(p => p.CanRead && p.CanWrite && p.HasCustomAttribute<GridAttribute>()))
            //{
            //    GridAttribute attr = propertyInfo.GetCustomAttribute<GridAttribute>();
            //    Control control = ModalModelo.FindControl(propertyInfo.Name);
            //    if (control != null && control is TextBox)
            //    {
            //        object value = ((TextBox)control).Text;
            //        if (string.IsNullOrEmpty(value.ToString()))
            //        {
            //            value = propertyInfo.IsNullable() ? Activator.CreateInstance(propertyInfo.PropertyType) : propertyInfo.GetPropertyType() == typeof(string) ? string.Empty : Activator.CreateInstance(propertyInfo.GetPropertyType());
            //        }
            //        else
            //        {
            //            if (propertyInfo.GetPropertyType() == typeof(decimal))
            //            {
            //                value = decimal.Parse(value.ToString(), new CultureInfo("pt-br"));
            //            }
            //        }

            //        propertyInfo.SetValue(Modelo, value != null ? Convert.ChangeType(value, propertyInfo.GetPropertyType()) : value);
            //    }
            //}

            //ModalModelo.Visible = false;
        }

        protected void CancelarModelo_Click(object sender, EventArgs e)
        {
            ModalModelo.DataBind();
            ModalModelo.Visible = false;
        }

        protected void ValidarEnviar_Click(object sender, EventArgs e)
        {
            ModalConfirmarEnvio.Visible = false;

            GridViewRow row = CurrRow();

            ItemValidacao itemValidacao = CarrinhoService.ObterItemValidacao(row);
            ItemData item = itemValidacao.Item;
            List<ItemErroValidacao> erros = itemValidacao.Erros;

            ImageButton btnEnviar = (ImageButton)row.Cells[1].FindControl("BtnEnviar");

            AlertErroValidacao.Visible = false;
            AlertEnvioOk.Visible = false;
            AlertEnvioErro.Visible = false;

            if (erros.Count > 0)
            {
                btnEnviar.ImageUrl = "~/Content/images/send-danger.svg";

                AlertErroValidacao.Visible = true;
                RepeaterErroValidacao.DataSource = erros;
                RepeaterErroValidacao.DataBind();
            }
            else
            {
                try
                {
                    //SadService.Enviar(item);

                    HiddenField enviado = (HiddenField)row.Cells[0].FindControl("Enviado");
                    enviado.Value = true.ToString();
                    CheckBox selecionado = (CheckBox)row.Cells[0].FindControl("Selecionado");
                    selecionado.Checked = false;
                    selecionado.Visible = false;

                    btnEnviar.ImageUrl = "~/Content/images/send-success.svg";
                    AlertEnvioOk.Visible = true;
                }
                catch (Exception ex)
                {
                    btnEnviar.ImageUrl = "~/Content/images/send-danger.svg";

                    AlertEnvioErro.Visible = true;
                    MsgAlertEnvioErro.Text = ex.Message;
                }
            }

            //foreach (PropertyInfo prop in item.GetType().GetProperties().Where(p => p.CanWrite && p.HasCustomAttribute<GridAttribute>()))
            //{
            //    //Control control = row.FindControl(prop.Name);
            //    //if (control != null && control is TextBox)
            //    //{
            //    //    TextBox textBox = (TextBox)control;
            //    //    if (item.enviado)
            //    //    {
            //    //        textBox.Enabled = false;
            //    //        textBox.CssClass = "form-control form-control-xsm";
            //    //    }
            //    //    else if (erros.Any(erro => erro.Campo == prop.Name))
            //    //    {
            //    //        textBox.CssClass = "form-control form-control-xsm border-danger";
            //    //    }
            //    //    else
            //    //    {
            //    //        textBox.CssClass = "form-control form-control-xsm";
            //    //    }
            //    //}
            //}


        }

        protected void btnModelo_Click(object sender, EventArgs e)
        {
            ModalModelo.DataBind();
            ModalModelo.Visible = true;
        }

        protected void AlternarSelecionadoCarrinho_CheckedChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridItens.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    bool enviado = bool.Parse(((HiddenField)row.Cells[0].FindControl("Enviado")).Value);
                    CheckBox selecionado = (CheckBox)row.Cells[0].FindControl("Selecionado");
                    selecionado.Checked = enviado ? false : ((CheckBox)sender).Checked;
                }
            }
        }

        protected void GridItens_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

            }
        }

        protected void BtnEnviar_Click(object sender, ImageClickEventArgs e)
        {
            GridViewRow row = (GridViewRow)((Control)sender).Parent.Parent;
            IdCarrinho = int.Parse(((HiddenField)row.Cells[0].FindControl("IdCarrinho")).Value);
            ItemNbr = int.Parse(row.Cells[2].Text);
            if (bool.Parse(((HiddenField)row.Cells[0].FindControl("Enviado")).Value))
            {
                ModalEnviado.Visible = true;
            }
            else
            {
                ModalConfirmarEnvio.Visible = true;
            }
        }

        protected void CancelarValidarEnviar_Click(object sender, EventArgs e)
        {
            IdCarrinho = 0;
            ItemNbr = 0;
            ModalConfirmarEnvio.Visible = false;
        }

        private GridViewRow CurrRow()
        {
            GridViewRow currRow = null;
            foreach (GridViewRow row in GridItens.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    int idCarrinho = int.Parse(((HiddenField)row.Cells[0].FindControl("IdCarrinho")).Value);
                    if (IdCarrinho == idCarrinho)
                    {
                        currRow = row;
                        break;
                    }
                }
            }

            return currRow;
        }

        protected void BtnFecharModalEnviado_Click(object sender, EventArgs e)
        {
            ModalEnviado.Visible = false;
        }

        protected void FecharAlertErroValidacao_Click(object sender, EventArgs e)
        {
            AlertErroValidacao.Visible = false;
        }

        protected void btnReplicar_Click(object sender, EventArgs e)
        {
            bool houveReplicacao = false;
            ItemData item = Modelo;
            foreach (GridViewRow row in GridItens.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    bool selecionado = ((CheckBox)row.Cells[0].FindControl("Selecionado")).Checked;
                    if (selecionado)
                    {
                        if (!houveReplicacao)
                        {
                            houveReplicacao = true;
                        }

                        //foreach (PropertyInfo prop in item.GetType().GetProperties().Where(p => p.HasCustomAttribute<GridAttribute>()))
                        //{
                        //    GridAttribute attr = prop.GetCustomAttribute<GridAttribute>();
                        //    object value = prop.GetValue(item);
                        //    if (value != null && !string.IsNullOrEmpty(value.ToString()))
                        //    {
                        //        Control control = row.FindControl(prop.Name);
                        //        if (control != null && control is TextBox)
                        //        {
                        //            TextBox textBox = control as TextBox;
                        //            if (!prop.IsNullable())
                        //            {
                        //                if (prop.IsTypeof<int>() || prop.IsTypeof<long>())
                        //                {
                        //                    if (long.Parse(value.ToString()) > 0)
                        //                    {
                        //                        textBox.Text = value.ToString();
                        //                    }
                        //                }
                        //            } else
                        //            {
                        //                textBox.Text = value.ToString();
                        //            }
                        //        }
                        //    }
                        //}
                    }
                }
            }

            if (houveReplicacao)
            {
                AlertType.Value = "alert-success";
                AlertMsg.Value = "O modelo foi replicado nos registros selecionados.";
            }
            else
            {
                AlertType.Value = "alert-warning";
                AlertMsg.Value = "Não existem dados no modelo ou nenhum registro foi selecionado.";
            }
        }

        protected void AbrirModalXls_Click(object sender, EventArgs e)
        {
            ModalXls.Visible = true;
        }

        protected void FecharModalXls_Click(object sender, EventArgs e)
        {
            ModalXls.Visible = false;
            OcultarAlerta(ModalXls_Alert);
        }

        protected void Importar_Click(object sender, EventArgs e)
        {
            if (!FileUpXls.HasFile)
            {
                ExibirAlerta(ModalXls_Alert, "alert-warning w-100", "Nenhum arquivo selecionado.");
                return;
            }

            //if (FileUpXls.PostedFile.ContentType != "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
            //{
            //    ExibirAlerta(ModalXls_Alert, "alert-warning w-100", "O arquivo informado não é do tipo esperado.");
            //    return;
            //}

            //try
            //{
            //    CarrinhoService.Importar(GridItens, 1, FileUpXls.PostedFile.InputStream);
            //    ExibirAlerta(ModalXls_Alert, "alert-success w-100", "Arquivo importado com sucesso!<br />Realize a validação/envio dos dados importados.");
            //}
            //catch (Exception ex)
            //{
            //    ExibirAlerta(ModalXls_Alert, "alert-danger w-100", ex.Message);
            //}
        }

        protected void Exportar_Click(object sender, EventArgs e)
        {
            //FileInfo outputFile = CarrinhoService.ObterExportacao(UserData.Login, MapPath(Properties.Settings.Default.filesVirtualPath));
            //string downloadVirtualPath = string.Format("{0}/{1}", Properties.Settings.Default.filesVirtualPath, outputFile.Name);
            //string downloadPath = ResolveUrl(downloadVirtualPath);

            //ScriptManager.RegisterStartupScript(this, typeof(string), "downloadFile", "document.getElementById('downloadLnk').click();", true);
            //ExibirAlerta(ModalXls_Alert, "alert-success w-100", "O arquivo <span class='alert-link'>{0}</span> foi exportado com sucesso.<br />Se o download não iniciar, clique <a id='downloadLnk' href='{1}' class='alert-link'>aqui</a>.", outputFile.Name, downloadPath);

            //ExibirAlerta(ModalXls_Alert, "alert-success w-100", "O arquivo <span class='alert-link'>{0}</span> foi exportado com sucesso.", outputFile.Name);
            //iFrameDownload.Src = downloadPath;

        }

       
    }
}