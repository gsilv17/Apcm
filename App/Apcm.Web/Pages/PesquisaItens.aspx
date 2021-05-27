<%@ Page Title="Pesquisa de Itens" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="PesquisaItens.aspx.cs" Inherits="Apcm.Web.Pages.PesquisaItens" EnableEventValidation="false" %>

<asp:Content ID="headPlaceHolder" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="<%: Page.ResolveUrl("~/Content/css/pages/pesquisaItens.css") %>" />
</asp:Content>

<asp:Content ID="bodyPlaceHolder" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:UpdatePanel ID="updatePanel" runat="server">
        <ContentTemplate>

            <div class="border-bottom border-secondary p-0 m-0 mb-3">
                <img alt="" src="<%: Page.ResolveUrl("~/Content/images/search.svg") %>" class="d-inline-block align-top ml-3 mr-2 header-image" />
                <span class="h4">Transição Sam's - Pesquisa de Itens</span>
            </div>

            <div class="form-row mb-2">
                <div class="col-sm-2 form-group mb-0">
                    <label for="Itens">
                        Código ou UPC do Item 
                    </label>
                    <asp:TextBox ID="Itens" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="form-control form-control-sm" placeholder="separados por enter"></asp:TextBox>
                </div>
                <div class="col-sm-2 form-group mb-0">
                    <label for="Fornecedores">
                        Fornecedor <span class="small text-muted d-inline-flex d-sm-none d-xl-inline-flex">(6 dígitos)</span>
                    </label>
                    <asp:TextBox ID="Fornecedores" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="form-control form-control-sm" placeholder="separados por enter"></asp:TextBox>
                </div>

                <div class="col-sm-8">

                    <div class="row mb-2">
                        <div class="col-sm-3">
                            <label for="Categoria">Categoria</label>
                            <button id="Categoria" runat="server" class="btn btn-sm btn-secondary w-100 d-flex justify-content-start" onserverclick="Categoria_ServerClick">
                                <i class="icons icons-rounded icon-search mr-1"></i>
                                <asp:Label ID="CategoriaDesc" runat="server">Todas</asp:Label>
                            </button>
                        </div>
                        <div class="col-sm-3">
                            <label for="Subcategoria">Subcategoria</label>
                            <button id="Subcategoria" runat="server" class="btn btn-sm btn-secondary w-100 d-flex justify-content-start" onserverclick="Subcategoria_ServerClick">
                                <i class="icons icons-rounded icon-search mr-1"></i>
                                <asp:Label ID="SubcategoriaDesc" runat="server">Todas</asp:Label>
                            </button>
                        </div>
                        <div class="col-sm-3">
                            <label for="Fineline">Fineline</label>
                            <button id="Fineline" runat="server" class="btn btn-sm btn-secondary w-100 d-flex justify-content-start" onserverclick="Fineline_ServerClick">
                                <i class="icons icons-rounded icon-search mr-1"></i>
                                <asp:Label ID="FinelineDesc" runat="server">Todas</asp:Label>
                            </button>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-3">
                            <label for="Categoria">Possui Cross?</label>
                            <asp:DropDownList ID="PossuiCross" runat="server" CssClass="form-control form-control-sm">
                                <asp:ListItem Selected="True" Value="-1" Text="Todos" />
                                <asp:ListItem Value="1" Text="Sim" />
                                <asp:ListItem Value="0" Text="Não" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-sm-3">
                            <label for="EmEdicao">Em Edição?</label>
                            <asp:DropDownList ID="EmEdicao" runat="server" CssClass="form-control form-control-sm">
                                <asp:ListItem Selected="True" Value="-1" Text="Todos" />
                                <asp:ListItem Value="1" Text="Sim" />
                                <asp:ListItem Value="0" Text="Não" />
                            </asp:DropDownList>
                        </div>

                        <div class="col-sm-2 align-self-end">
                            <asp:Button ID="Pesquisar" runat="server" Text="Pesquisar" CssClass="btn btn-sm btn-primary text-truncate w-100" OnClick="Pesquisar_Click" />
                        </div>
                        <div class="col-sm-2 align-self-end">
                            <asp:Button ID="Limpar" runat="server" Text="Limpar" CssClass="btn btn-sm btn-secondary text-truncate w-100" OnClick="Limpar_Click" />
                        </div>
                        <div class="col-sm-2 align-self-end">
                            <div class="dropdown">
                                <button class="btn btn-sm btn-primary w-100 dropdown-toggle" type="button" id="Finalizar" runat="server" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Gerar o Carrinho
                                </button>
                                <div class="dropdown-menu" aria-labelledby="<%: Finalizar.ClientID %>" style="z-index: 1021 !important">
                                    <asp:LinkButton ID="CarrinhoProdutoGrid" runat="server" CssClass="dropdown-item" Text="Produto e Grid" OnClick="CarrinhoProdutoGrid_Click" ></asp:LinkButton>
                                    <asp:LinkButton ID="CarrinhoGrid" runat="server" CssClass="dropdown-item" Text="Somente Grid" OnClick="CarrinhoGrid_Click"></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="row">
                <div class="col">
                    <asp:HiddenField ID="AlertMsg" runat="server" />
                    <asp:HiddenField ID="AlertType" runat="server" />
                    <%if (!string.IsNullOrEmpty(AlertMsg.Value))
                        { %>
                    <label class='alert alert-sm w-100 mb-2 <%: AlertType.Value %>'><%: AlertMsg.Value %></label>
                    <%} %>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3-lateral">
                    Itens Localizados:
                    <asp:Label ID="ItensLocalizados" runat="server" CssClass="font-weight-bold" />
                    <div class="scroll-box">
                        <asp:GridView
                            ID="GridPesquisa"
                            runat="server"
                            AutoGenerateColumns="false"
                            CssClass="table table-borderless table-sm table-fixed"
                            ItemType="Apcm.Service.Item.PesquisaPrateleiraResultado"
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
                                        <asp:HiddenField ID="PodeSelecionar" runat="server" Value='<%# Item.PodeSelecionar %>' />
                                        <asp:CheckBox ID="Selecionado" runat="server" Checked='<%# Item.Selecionado %>' Visible='<%# Item.PodeSelecionar || AppUser.Admin %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="item_nbr" HeaderText="Código do item SAM'S" HeaderStyle-CssClass="sticky-top" />
                                <asp:TemplateField HeaderText="Descrição do item">
                                    <HeaderStyle CssClass="sticky-top" />
                                    <ItemTemplate>
                                        <span class="small text-muted <%# Item.PodeSelecionar ? "d-none" : "" %>">(<%# Item.Nome %>)</span> <%# Item.item1_desc %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="vendor_nbr" HeaderText="Código do Vendor (6 digitos)" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="codCategoria" HeaderText="Código da Categoria" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="descrCategoria" HeaderText="Descrição da Categoria" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="codSubcategoria" HeaderText=" Código da Subcategoria" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="DescrSubcategoria" HeaderText=" Descrição da Subcategoria" HeaderStyle-CssClass="sticky-top" />


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
                    Itens no carrinho: <span class="font-weight-bold <%: GridCarrinho.Rows.Count > 1000 ? "text-danger" : "" %>"><%: GridCarrinho.Rows.Count.ToString("N0") %></span>
                    <span class="text-danger small <%: GridCarrinho.Rows.Count > 1000 ? "" : "d-none" %>">- O carrinho não pode conter mais de 1.000 Itens.</span>
                    <div class="scroll-box">
                        <asp:GridView
                            ID="GridCarrinho"
                            runat="server"
                            AutoGenerateColumns="false"
                            CssClass="table table-borderless table-sm table-fixed"
                            ItemType="Apcm.Service.Item.PesquisaPrateleiraResultado"
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
                                        <asp:CheckBox ID="Selecionado" runat="server" Checked='<%# Item.Selecionado %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="item_nbr" HeaderText="Código do item SAM'S" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="item1_desc" HeaderText="Descrição do item" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="vendor_nbr" HeaderText="Código do Vendor (6 digitos)" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="codCategoria" HeaderText="Código da Categoria" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="descrCategoria" HeaderText="Descrição da Categoria" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="codSubcategoria" HeaderText=" Código da Subcategoria" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="DescrSubcategoria" HeaderText=" Descrição da Subcategoria" HeaderStyle-CssClass="sticky-top" />

                            </Columns>
                        </asp:GridView>
                    </div>

                </div>
            </div>

            <div id="ModalEstrutura" runat="server" visible="false">
                <div class="modal-backdrop show"></div>
                <div class="modal" style="display: block">
                    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                        <div class="modal-content">
                            <div class="modal-header">


                                <h5 class="modal-title">
                                    <asp:Label ID="ModalEstruturaTitulo" runat="server"></asp:Label>
                                </h5>

                                <div class="float-right form-inline justify-content-end">
                                    <asp:TextBox ID="FiltroEstrutura" runat="server" CssClass="form-control form-control-sm w-300px"></asp:TextBox>
                                    <asp:Button ID="FiltrarEstrutura" runat="server" CssClass="btn btn-secondary btn-sm w-100px ml-2 mr-2" Text="Filtrar" OnClick="FiltrarEstrutura_Click" />
                                    <asp:Button ID="LimparFiltroEstrutura" runat="server" CssClass="btn btn-secondary btn-sm w-100px" Text="Limpar" OnClick="LimparFiltroEstrutura_Click" />
                                </div>


                            </div>
                            <div class="modal-body">
                                <div class="scroll-box" style="height: 350px; width: 100%;">
                                    <asp:GridView
                                        ID="GridEstrutura"
                                        runat="server"
                                        AutoGenerateColumns="false"
                                        CssClass="table table-borderless table-sm table-fixed"
                                        ItemType="Apcm.Service.EstruturaMercadologica.EstruturaMercadologicaSamsData"
                                        Width="100%">
                                        <HeaderStyle CssClass="thead-dark" HorizontalAlign="Center" />
                                        <RowStyle CssClass="text-center" />
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemStyle HorizontalAlign="Center" CssClass="sticky-left" />
                                                <HeaderStyle CssClass="sticky-top-left text-center" Width="40px" />
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="AlternarSelecaoEstrutura" runat="server" AutoPostBack="true" OnCheckedChanged="AlternarSelecaoEstrutura_CheckedChanged" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="Selecionado" runat="server" Checked='<%# Item.Selecionado %>' />
                                                    <asp:HiddenField ID="CodCategoria" runat="server" Value='<%# Item.CodCategoria %>' />
                                                    <asp:HiddenField ID="CodSubcategoria" runat="server" Value='<%# Item.CodSubcategoria %>' />
                                                    <asp:HiddenField ID="CodFineline" runat="server" Value='<%# Item.CodFineline %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CodCategoria" HeaderText="Cod. Cat." HeaderStyle-CssClass="sticky-top" HeaderStyle-Width="100px" />
                                            <asp:BoundField DataField="DescrCategoria" HeaderText="Categoria" HeaderStyle-CssClass="sticky-top" />
                                            <asp:BoundField DataField="CodSubcategoria" HeaderText="Cod. Sub." HeaderStyle-CssClass="sticky-top" HeaderStyle-Width="100px" />
                                            <asp:BoundField DataField="DescrSubcategoria" HeaderText="Subcategoria" HeaderStyle-CssClass="sticky-top" />
                                            <asp:BoundField DataField="CodFineline" HeaderText="Cod. Fin." HeaderStyle-CssClass="sticky-top" HeaderStyle-Width="100px" />
                                            <asp:BoundField DataField="DescrFineline" HeaderText="Fineline" HeaderStyle-CssClass="sticky-top" />
                                        </Columns>
                                    </asp:GridView>

                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="ModalestruturaOk" runat="server" Text="Ok" CssClass="btn btn-sm btn-success w-100px" OnClick="ModalestruturaOk_Click" />
                                <asp:Button ID="ModalEstruturaCancelar" runat="server" Text="Cancelar" CssClass="btn btn-sm btn-secondary w-100px" OnClick="ModalEstruturaCancelar_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="ModalCarrinho" runat="server" visible="false">
                <div class="modal-backdrop show"></div>
                <div class="modal" style="display: block">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Existem itens em edição em outros carrinhos.<br />
                                    Deseja liberar esses itens antes de gerar o carrinho?
                                </h5>
                            </div>
                            <div class="modal-footer">
                                <asp:HiddenField ID="SomenteGrid" runat="server" />
                                <asp:Button ID="ConfirmarCarrinhoTotal" runat="server" Text="Sim, Liberar todos." CssClass="btn btn-sm btn-danger" OnClick="ConfirmarCarrinhoTotal_Click" />
                                <asp:Button ID="ConfirmarCarrinhoParcial" runat="server" Text="Não, Considerar itens fora de uso." CssClass="btn btn-sm btn-primary" OnClick="ConfirmarCarrinhoParcial_Click" />
                                <asp:Button ID="CancelarCarrinho" runat="server" Text="Cancelar" CssClass="btn btn-sm btn-secondary" OnClick="CancelarCarrinho_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

<asp:Content ID="scriptPlaceHolder" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="text/javascript" src="<%: Page.ResolveUrl("~/Content/js/pages/pesquisaItens.js") %>"></script>
</asp:Content>
