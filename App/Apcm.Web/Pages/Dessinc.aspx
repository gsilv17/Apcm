<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="Dessinc.aspx.cs" Inherits="Apcm.Web.Pages.Dessinc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="<%: Page.ResolveUrl("~/Content/css/pages/dessinc.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel" runat="server">
        <ContentTemplate>

            <div class="border-bottom border-secondary p-0 m-0 mb-3">
                <i class="icons icons-rounded icon-link_off d-inline-block align-top ml-3 mr-2"></i>
                <span class="h4">Dessincronização de Itens / Produtos - Sam's</span>
            </div>

            <div class="row">
                <div class="col-2">
                    <label for="Itens">
                        Código do Produto
                    </label>
                    <asp:TextBox ID="ProdutoNbr" runat="server" MaxLength="10" CssClass="form-control form-control-sm ts-input-numerico"></asp:TextBox>
                </div>

                <div class="col-2 align-self-end">
                    <asp:Button ID="Pesquisar" runat="server" Text="Pesquisar" CssClass="btn btn-sm btn-primary text-truncate w-100" OnClick="Pesquisar_Click" />
                </div>
                <div class="col-2 align-self-end">
                    <asp:Button ID="Limpar" runat="server" Text="Limpar" CssClass="btn btn-sm btn-secondary text-truncate w-100" OnClick="Limpar_Click" />
                </div>


            </div>

            <div class="row mt-3">
                <div class="col-2 align-self-end d-none">
                    <asp:Button ID="DessincLocal" runat="server" Text="Remover Link" CssClass="btn btn-sm btn-info text-truncate w-100 d-none" OnClick="DessincLocal_Click" Enabled="false" />
                </div>
                <div class="col-3 align-self-end">
                    <asp:Button ID="DessincTotal" runat="server" Text="Remover Link e Deletar Produto" CssClass="btn btn-sm btn-info text-truncate w-100" OnClick="DessincTotal_Click" Enabled="false" />
                </div>
                <div class="col-3 align-self-end">
                    <asp:Button ID="DessincSad" runat="server" Text="Deletar Produto" CssClass="btn btn-sm btn-info text-truncate w-100" OnClick="DessincSad_Click" Enabled="false" />
                </div>
                <div class="col-6 align-self-end">
                    <asp:HiddenField ID="AlertMsg" runat="server" />
                    <asp:HiddenField ID="AlertType" runat="server" />
                    <%if (!string.IsNullOrEmpty(AlertMsg.Value))
                        { %>
                    <label class='alert alert-sm w-100 <%: AlertType.Value %>'><%: AlertMsg.Value %></label>
                    <%} %>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col">
                    Itens Localizados: <span class="font-weight-bold"><%: GridDessinc.Rows.Count.ToString("N0") %></span>

                    <div class="scroll-box">
                        <asp:GridView
                            ID="GridDessinc"
                            runat="server"
                            AutoGenerateColumns="false"
                            CssClass="table table-borderless table-sm table-fixed"
                            ItemType="Apcm.Service.Cross.CrossData">
                            <HeaderStyle CssClass="thead-dark" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemStyle HorizontalAlign="Center" CssClass="sticky-left" />
                                    <HeaderStyle CssClass="sticky-top-left text-center" Width="40px" />
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="AlternarSelecao" runat="server" AutoPostBack="true" OnCheckedChanged="AlternarSelecao_CheckedChanged" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:HiddenField ID="IdCross" runat="server" Value='<%# Item.IdCross %>' />
                                        <asp:HiddenField ID="EmEdicao" runat="server" Value='<%# Item.EmEdicao %>' />
                                        <asp:CheckBox ID="Selecionado" runat="server" Visible='<%# !Item.EmEdicao %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ItemNbr" HeaderText="Código do item" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" ItemStyle-Width="200px" />
                                <asp:TemplateField HeaderText="Descrição do item">
                                    <HeaderStyle CssClass="sticky-top" />
                                    <ItemTemplate>
                                        <span class="small text-muted <%# !Item.EmEdicao ? "d-none" : "" %>">(<%# Item.Nome %>)</span> <%# Item.ProdutoDesc %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                </div>
            </div>

            <div id="ModalDessinc" runat="server" visible="false">
                <div class="modal-backdrop show"></div>
                <div class="modal" style="display: block">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    Atenção! Esta ação não poderá ser desfeita!<br />
                                    <asp:Label ID="MsgDessincLocal" runat="server">Deseja remover a associação do produto aos itens selecionados?</asp:Label>
                                    <asp:Label ID="MsgDessincTotal" runat="server">Deseja remover a associação do produto a todos as itens e deletar o produto no SAD?</asp:Label>
                                    <asp:Label ID="MsgDessincSad" runat="server">Este produto não possui itens associados. Deseja deletar o produto no SAD?</asp:Label>
                                </h5>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="ConfirmarDessincLocal" runat="server" Text="Sim" CssClass="btn btn-sm btn-danger" OnClick="ConfirmarDessincLocal_Click" />
                                <asp:Button ID="ConfirmarDessincTotal" runat="server" Text="Sim" CssClass="btn btn-sm btn-danger" OnClick="ConfirmarDessincTotal_Click" />
                                <asp:Button ID="ConfirmarDessincSad" runat="server" Text="Sim" CssClass="btn btn-sm btn-danger" OnClick="ConfirmarDessincSad_Click" />
                                <asp:Button ID="CancelarDessinc" runat="server" Text="Não" CssClass="btn btn-sm btn-secondary" OnClick="CancelarDessinc_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="module" src="<%: Page.ResolveUrl("~/Content/js/pages/dessinc.js") %>"></script>
</asp:Content>
