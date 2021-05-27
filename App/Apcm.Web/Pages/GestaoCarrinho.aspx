<%@ Page Title="Gestão de Carrinhos" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="GestaoCarrinho.aspx.cs" Inherits="Apcm.Web.Pages.GestaoCarrinho" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="<%: Page.ResolveUrl("~/Content/css/pages/gestaoCarrinho.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <div class="border-bottom border-secondary p-0 m-0 mb-3">
        <img alt="" src="<%: Page.ResolveUrl("~/Content/images/shopping-cart.svg") %>" class="d-inline-block align-top ml-3 mr-2 header-image" />
        <span class="h4">Gestão de Carrinhos</span>
    </div>

    <div class="form-row">
        <div class="col-sm-2 form-group">
            <label for="Itens">
                Código ou UPC do Item 
            </label>
            <asp:TextBox ID="Itens" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="form-control form-control-sm" placeholder="separados por enter"></asp:TextBox>
        </div>
        <div class="col-sm-2 form-group">
            <label for="Itens">
                Código do Produto
            </label>
            <asp:TextBox ID="Produtos" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="form-control form-control-sm" placeholder="separados por enter"></asp:TextBox>
        </div>

        <div class="col-sm-8">
            <div class="row mb-2">
                <div class="col-sm-3">
                    <label for="Categoria">Usuário</label>
                    <asp:TextBox ID="Usuario" runat="server" MaxLength="100" CssClass="form-control form-control-sm" placeholder="Login de rede / SAMS ou Nome"></asp:TextBox>
                </div>
                <div class="col-sm-2 align-self-end">
                    <asp:Button ID="Pesquisar" runat="server" Text="Pesquisar" CssClass="btn btn-sm btn-primary text-truncate w-100" OnClick="Pesquisar_Click" />
                </div>
                <div class="col-sm-2 align-self-end">
                    <asp:Button ID="Limpar" runat="server" Text="Limpar" CssClass="btn btn-sm btn-secondary text-truncate w-100" OnClick="Limpar_Click" />
                </div>
                <div class="col-sm-3 align-self-end">
                    <asp:Button ID="Remover" runat="server" Text="Liberar Itens Selecionados"
                        CssClass="btn btn-sm btn-primary text-truncate w-100" OnClick="Remover_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col-sm-10 pb-1">
                    <asp:HiddenField ID="AlertMsg" runat="server" />
                    <asp:HiddenField ID="AlertType" runat="server" />
                    <%if (!string.IsNullOrEmpty(AlertMsg.Value))
                        { %>
                    <label class='alert alert-sm w-100 <%: AlertType.Value %>'><%: AlertMsg.Value %></label>
                    <%} %>
                </div>

            </div>

        </div>
    </div>

    <div class="row tm-2">
        <div class="col">
            Itens localizados: <span class="font-weight-bold"><%: GridItens.Rows.Count.ToString("N0") %></span>
            
            <div class="scroll-box">
                <asp:GridView
                    ID="GridItens"
                    runat="server"
                    AutoGenerateColumns="false"
                    CssClass="table table-borderless table-sm table-fixed"
                    ItemType="Apcm.Service.Carrinho.GestaoCarrinhoItens"
                    Width="100%">
                    <HeaderStyle CssClass="thead-dark" />
                    <Columns>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="sticky-top-left text-center" Width="40px" />
                            <ItemStyle HorizontalAlign="Center" CssClass="sticky-left" />
                            <HeaderTemplate>
                                <asp:CheckBox ID="AlternarSelecao" runat="server" AutoPostBack="true" OnCheckedChanged="AlternarSelecao_CheckedChanged" Checked="true" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="Selecionado" runat="server" Checked="true"/>
                                <asp:HiddenField ID="IdCarrinhoItem" runat="server" Value='<%# Item.IdCarrinhoItem.ToString() %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Login" HeaderText="Login Rede" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="LoginSad" HeaderText="Login SAD" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="CodSistema" HeaderText="Sistema" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="Nome" HeaderText="Nome" HeaderStyle-CssClass="sticky-top text-center" />
                        <asp:BoundField DataField="item_nbr" HeaderText="Código do item SAM'S" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="produto_nbr" HeaderText="Código do produto SAD" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="Descr" HeaderText="Descrição do item SAM'S" HeaderStyle-CssClass="sticky-top text-center" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <div id="ModalRemover" runat="server" visible="false">
        <div class="modal-backdrop show"></div>
        <div class="modal" style="display: block">
            <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <asp:Label ID="RemoverMsg" runat="server"></asp:Label>
                        </h5>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="ConfirmarRemover" runat="server" Text="Sim" CssClass="btn btn-sm btn-danger" OnClick="ConfirmarRemover_Click" />
                        <asp:Button ID="CancelarRemover" runat="server" Text="Não" CssClass="btn btn-sm btn-secondary" OnClick="CancelarRemover_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="text/javascript" src="<%: Page.ResolveUrl("~/Content/js/pages/gestaoCarrinho.js") %>"></script>
</asp:Content>
