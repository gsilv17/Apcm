<%@ Page Title="Pesquisa de Produtos" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="PesquisaProdutos.aspx.cs" Inherits="Apcm.Web.Pages.PesquisaProdutos" EnableEventValidation="false" %>

<asp:Content ID="HeadPlaceHolder" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="<%: Page.ResolveUrl("~/Content/css/pages/pesquisaProdutos.css") %>" />
</asp:Content>
<asp:Content ID="BodyPlaceHolder" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel" runat="server">
        <ContentTemplate>

            <div class="border-bottom border-secondary p-0 m-0 mb-3">
                <img alt="" src="<%: Page.ResolveUrl("~/Content/images/search.svg") %>" class="d-inline-block align-top ml-3 mr-2 header-image" />
                <span class="h4"><asp:Label runat="server" ID="PageTitle"></asp:Label></span>
            </div>

            <div class="form-row">
                <div class="col-sm-2 form-group">
                    <label for="Itens">
                        Código ou EAN do Produto 
                    </label>
                    <asp:TextBox ID="Itens" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="form-control form-control-sm" placeholder="separados por enter"></asp:TextBox>
                </div>

                <div class="col-sm-10">
                    <div class="row mb-2">
                        <div class="col-sm-4">
                            <label for="Categoria">Seção</label>
                            <asp:DropDownList ID="Secao" runat="server" CssClass="form-control form-control-sm" DataValueField="Key" DataTextField="Value" AutoPostBack="true" OnSelectedIndexChanged="CarregarLinha"></asp:DropDownList>
                        </div>
                        <div class="col-sm-4">
                            <label for="Subcategoria">Linha</label>
                            <asp:DropDownList ID="Linha" runat="server" CssClass="form-control form-control-sm" DataValueField="Key" DataTextField="Value" AutoPostBack="true" OnSelectedIndexChanged="CarregarSublinha"></asp:DropDownList>
                        </div>
                        <div class="col-sm-4">
                            <label for="Fineline">Sublinha</label>
                            <asp:DropDownList ID="Sublinha" runat="server" CssClass="form-control form-control-sm" DataValueField="Key" DataTextField="Value"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-2 pb-1">
                            <asp:Button ID="Pesquisar" runat="server" Text="Pesquisar" CssClass="btn btn-sm btn-primary text-truncate w-100" OnClick="Pesquisar_Click" />
                        </div>
                        <div class="col-sm-2 pb-1">
                            <asp:Button ID="Limpar" runat="server" Text="Limpar" CssClass="btn btn-sm btn-secondary text-truncate w-100" OnClick="Limpar_Click" />
                        </div>
                        <div class="col-sm-2 pb-1">
                            <div class="dropdown">
                                <button class="btn btn-sm btn-primary w-100 dropdown-toggle" type="button" id="Finalizar" runat="server" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Gerar Planilha
                                </button>
                                <div class="dropdown-menu" aria-labelledby="<%: Finalizar.ClientID %>" style="z-index: 1021 !important">
                                    <asp:LinkButton ID="CarrinhoProdutoGrid" runat="server" CssClass="dropdown-item" Text="Produto e Grid" OnClick="CarrinhoProdutoGrid_Click" ></asp:LinkButton>
                                    <asp:LinkButton ID="CarrinhoGrid" runat="server" CssClass="dropdown-item" Text="Somente Grid" OnClick="CarrinhoGrid_Click"></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 pb-1">
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

            <div class="row mt-3">
                <div class="col-md-3-lateral">
                    Produtos Localizados: <span class="font-weight-bold"><%: GridPesquisa.Rows.Count.ToString("N0") %></span>

                    <div class="scroll-box">
                        <asp:GridView
                            ID="GridPesquisa"
                            runat="server"
                            AutoGenerateColumns="false"
                            CssClass="table table-borderless table-sm table-fixed"
                            ItemType="Apcm.Service.Sad.ProdutoData"
                            Width="1500px">
                            <HeaderStyle CssClass="thead-dark" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemStyle HorizontalAlign="Center" CssClass="sticky-left" />
                                    <HeaderStyle CssClass="sticky-top-left text-center" Width="40px" />
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="AlternarSelecionadoPesquisa" runat="server" AutoPostBack="true" OnCheckedChanged="AlternarSelecionado_CheckedChanged" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:HiddenField ID="ProdutoJSon" runat="server" Value='<%# Item.ProdutoJSon %>' />
                                        <asp:CheckBox ID="Selecionado" runat="server" Checked='<%# Item.Selecionado %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="CodProd" HeaderText="Código do Produto" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.Desc" HeaderText="Descrição do Produto" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.Secao" HeaderText="Seção" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.SecaoDesc" HeaderText="Descrição da Seção" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.Linha" HeaderText="Linha" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.LinhaDesc" HeaderText="Descrição da Linha" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.Slinha" HeaderText="Sublinha" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.SlinhaDesc" HeaderText="Descrição da Sublinha" HeaderStyle-CssClass="sticky-top" />
                            </Columns>
                        </asp:GridView>
                    </div>

                </div>

                <div class="col-md-3-central d-flex justify-content-center align-items-center flex-row flex-md-column p-md-0">
                    <br />
                    <asp:Button ID="Incluir" runat="server" Text="Incluir" CssClass="btn btn-sm btn-primary w-100 m-1 text-truncate" OnClick="Incluir_Click" />
                    <asp:Button ID="Remover" runat="server" Text="Remover" CssClass="btn btn-sm btn-secondary w-100 m-1 text-truncate" OnClick="Remover_Click" />
                    <br />
                </div>

                <div class="col-md-3-lateral">
                    Produtos no carrinho: <span class="font-weight-bold <%: GridCarrinho.Rows.Count > 1000 ? "text-danger" : "" %>"><%: GridCarrinho.Rows.Count.ToString("N0") %></span>
                    <span class="text-danger small <%: GridCarrinho.Rows.Count > 1000 ? "" : "d-none" %>">- O carrinho não pode conter mais de 1.000 Produtos.</span>
                    <div class="scroll-box">
                        <asp:GridView
                            ID="GridCarrinho"
                            runat="server"
                            AutoGenerateColumns="false"
                            CssClass="table table-borderless table-sm table-fixed"
                            ItemType="Apcm.Service.Sad.ProdutoData"
                            Width="1500px">
                            <HeaderStyle CssClass="thead-dark" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemStyle HorizontalAlign="Center" CssClass="sticky-left" />
                                    <HeaderStyle CssClass="sticky-top-left text-center" Width="40px" />
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="AlternarSelecionadoCarrinho" runat="server" AutoPostBack="true" OnCheckedChanged="AlternarSelecionado_CheckedChanged" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:HiddenField ID="ProdutoJSon" runat="server" Value='<%# Item.ProdutoJSon %>' />
                                        <asp:CheckBox ID="Selecionado" runat="server" Checked='<%# Item.Selecionado %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="CodProd" HeaderText="Código do Produto" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.Desc" HeaderText="Descrição do Produto" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.Secao" HeaderText="Seção" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.SecaoDesc" HeaderText="Descrição da Seção" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.Linha" HeaderText="Linha" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.LinhaDesc" HeaderText="Descrição da Linha" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.Slinha" HeaderText="Sublinha" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="Basico.SlinhaDesc" HeaderText="Descrição da Sublinha" HeaderStyle-CssClass="sticky-top" />
                            </Columns>
                        </asp:GridView>
                    </div>

                </div>
            </div>

            <%--<div id="ModalDessinc" runat="server" visible="false">
                <div class="modal-backdrop show"></div>
                <div class="modal" style="display: block">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    Atenção!<br />
                                    Esta ação irá remover o produto da cross reference, remover seus relacionamentos e excluir o produto no SAD!<br />
                                    <br />
                                    Deseja realmente dessincronizar os itens selecionados?
                                </h5>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="ConfirmarDessinc" runat="server" Text="Sim" CssClass="btn btn-sm btn-danger" OnClick="ConfirmarDessinc_Click" />
                                <asp:Button ID="CancelarDessinc" runat="server" Text="Não" CssClass="btn btn-sm btn-secondary" OnClick="CancelarDessinc_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>--%>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="ScriptPlaceHolder" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="text/javascript" src="<%: Page.ResolveUrl("~/Content/js/pages/pesquisaProdutos.js") %>"></script>
</asp:Content>
