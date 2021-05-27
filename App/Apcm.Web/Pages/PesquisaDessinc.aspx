<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="PesquisaDessinc.aspx.cs" Inherits="Apcm.Web.Pages.PesquisaDessinc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="<%: Page.ResolveUrl("~/Content/css/pages/pesquisaDessinc.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel" runat="server">
        <ContentTemplate>

            <div class="border-bottom border-secondary p-0 m-0 mb-3">
                <i class="icons icons-rounded icon-search d-inline-block align-top ml-3 mr-2"></i>
                <span class="h4">Pesquisa de Dessincronização de Itens / Produtos - Sam's</span>
            </div>

            <div class="row">
                <div class="col-2">
                    <label for="Itens">
                        Código do Produto
                    </label>
                    <asp:TextBox ID="ProdutoNbr" runat="server" MaxLength="10" CssClass="form-control form-control-sm ts-input-numerico"></asp:TextBox>
                </div>
                <div class="col-2">
                    <label for="Itens">
                        Código do Item
                    </label>
                    <asp:TextBox ID="ItemNbr" runat="server" MaxLength="10" CssClass="form-control form-control-sm ts-input-numerico"></asp:TextBox>
                </div>
                <div class="col-2 align-self-end">
                    <asp:Button ID="Pesquisar" runat="server" Text="Pesquisar" CssClass="btn btn-sm btn-primary text-truncate w-100" OnClick="Pesquisar_Click" />
                </div>
                <div class="col-2 align-self-end">
                    <asp:Button ID="Limpar" runat="server" Text="Limpar" CssClass="btn btn-sm btn-secondary text-truncate w-100" OnClick="Limpar_Click" />
                </div>
                 <div class="col-4 align-self-end">
                    <asp:HiddenField ID="AlertType" runat="server" />
                    <asp:HiddenField ID="AlertMsg" runat="server" />
                    <%if (!string.IsNullOrEmpty(AlertMsg.Value))
                        { %>
                    <label class='alert alert-sm w-100 <%: AlertType.Value %>'><%: AlertMsg.Value %></label>
                    <%} %>
                </div>

            </div>
            
            <div class="row mt-3">
                <div class="col">
                    <div class="scroll-box">
                        <asp:GridView
                            ID="GridPesquisa"
                            runat="server"
                            AutoGenerateColumns="false"
                            CssClass="table table-borderless table-sm table-fixed"
                            ItemType="Apcm.Service.Cross.DessincPesquisaData">
                            <HeaderStyle CssClass="thead-dark" />
                            <Columns>
                                <asp:BoundField DataField="ProdutoNbr" HeaderText="Código do Produto" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                                <asp:BoundField DataField="ItemNbr" HeaderText="Código do Item" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                                <asp:BoundField DataField="TipoDessinc" HeaderText="Dessincronização" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                                <asp:BoundField DataField="Nome" HeaderText="Usuário" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                                <asp:TemplateField HeaderText="Data e Hora">
                                    <HeaderStyle CssClass="sticky-top text-center" />
                                    <ItemStyle CssClass="text-center" />
                                    <ItemTemplate>
                                        <%# Item.Data.ToString("dd/MM/yy - HH:mm:ss") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                </div>
            </div>

            

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="text/javascript" src="<%: Page.ResolveUrl("~/Content/js/pages/pesquisaDessinc.js") %>"></script>
</asp:Content>
