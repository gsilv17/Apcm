<%@ Page Title="Novos Produtos" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="NovosProdutos.aspx.cs" Inherits="Apcm.Web.Pages.NovosProdutos" %>
<asp:Content ID="HeadPlaceHolder" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="<%: Page.ResolveUrl("~/Content/css/pages/novosProdutos.css") %>" />
</asp:Content>
<asp:Content ID="BodyPlaceHolder" ContentPlaceHolderID="bodyPlaceHolder" runat="server">

    <div class="border-bottom border-secondary p-0 m-0 mb-3">
        <i class="icons icons-rounded icon-add_task d-inline-block align-top ml-3 mr-2"></i>
        <span class="h4">Criação de Novos Produtos - <%: PageParameters.CodSistema == "Atacado" ? "Sam's" : "Varejo" %></span>
    </div>

    <div class="row">

        <div class="col">
            <div class="input-group input">
                
                <div class="input-group-prepend">
                    <asp:button id="Exportar" runat="server" text="Exportar" cssclass="btn btn-secondary w-100 ts-modal-espera-click" onclick="Exportar_Click" />
                </div> 
                <div class="custom-file">
                    <asp:fileupload id="FileUpXls" runat="server" cssclass="custom-file-input" />
                    <asp:Label ID="fileUpXlsLabel" runat="server" AssociatedControlID="FileUpXls" data-browse="Selecionar e Enviar" CssClass="custom-file-label">Selecione um arquivo...</asp:Label>
                </div>
                <div class="input-group-append d-none">
                    <asp:button id="Importar" runat="server" cssclass="btn btn-secondary ts-modal-espera-click "  text="Importar" onclick="Importar_Click" />
                </div>
            </div>

        </div>

    </div>

    <div class="row mt-2">
        <div class="col">
            <asp:hiddenfield id="AlertMsg" runat="server" />
            <asp:hiddenfield id="AlertType" runat="server" />
            <%if (!string.IsNullOrEmpty(AlertMsg.Value))
                { %>
            <label class='alert alert-sm w-100 <%: AlertType.Value %>'><%: AlertMsg.Value %></label>
            <%} %>
        </div>
    </div>

    <iframe id="iFrameDownload" runat="server" style="visibility: hidden; width: 0; height: 0;"></iframe>

</asp:Content>
<asp:Content ID="ScriptPlaceHolder" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="module" src="<%: Page.ResolveUrl("~/Content/js/pages/NovosProdutos.js") %>"></script>
</asp:Content>
