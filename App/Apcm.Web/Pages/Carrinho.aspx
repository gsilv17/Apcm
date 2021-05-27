<%@ Page Title="Carrinho" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="Carrinho.aspx.cs" Inherits="Apcm.Web.Pages.Carrinho" EnableEventValidation="false" %>

<asp:Content ID="HeadPlaceHolder" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="<%: Page.ResolveUrl("~/Content/css/pages/carrinho.css") %>" />
</asp:Content>
<asp:Content ID="BodyPlaceHolder" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <div class="border-bottom border-secondary p-0 m-0 mb-3">
        <img alt="" src="<%: Page.ResolveUrl("~/Content/images/shopping-cart.svg") %>" class="d-inline-block align-top ml-3 mr-2 header-image" />
        <span class="h4">Carrinho - <%: PageParameters.CodSistema == "Atacado" ? "Sam's" : "Varejo" %></span>
    </div>

    <div class="row">

        <div class="col-7 ">
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text w-100" id="inputGroup-carinhos">Carrinhos Disponíveis</span>
                </div>
                <asp:dropdownlist id="Carrinhos" aria-describedby="inputGroup-carrinhos" runat="server" cssclass="form-control" datavaluefield="Key" datatextfield="Value" autopostback="true" onselectedindexchanged="Carrinhos_SelectedIndexChanged"></asp:dropdownlist>
                <div class="input-group-append">
                    <asp:button id="Exportar" runat="server" text="Exportar" cssclass="btn btn-secondary w-100 disabled ts-modal-espera-click" enabled="false" onclick="Exportar_Click" />
                </div>
                <div class="input-group-append">
                    <asp:button id="Remover" runat="server" cssclass="btn btn-secondary ts-modal-espera-click" enabled="false" text="Remover" onclick="Remover_Click" />
                </div>          
            </div>

        </div>

        <div class="col">
            <div class="input-group input">
                
                <div class="custom-file">
                    <asp:fileupload id="FileUpXls" runat="server" cssclass="custom-file-input" />
                    <asp:Label ID="fileUpXlsLabel" runat="server" AssociatedControlID="FileUpXls" data-browse="Selecionar e Importar" CssClass="custom-file-label">Selecione um arquivo...</asp:Label>
                </div>
                <div class="input-group-append d-none">
                    <asp:button id="Importar" runat="server" cssclass="btn btn-secondary ts-modal-espera-click disabled" enabled="false" text="Importar" onclick="Importar_Click" />
                </div>
                <div class="input-group-append">
                    <asp:button id="Enviar" runat="server" cssclass="btn btn-secondary disabled ts-modal-espera-click" enabled="false" text="Enviar" onclick="Enviar_Click" />
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

    <div id="dvGridItens" runat="server" class="row tm-2">
        <div class="col">
            <% if (GridItens.Rows.Count > 0)
                {
            %>
            <div style='<%: GridItens.Rows.Count == 0 ? "display:none" : "display:block" %>'></div>
            Itens disponíveis para edição: <span class="font-weight-bold"><%: GridItens.Rows.Count.ToString("N0") %></span>
            -
                    Último Lote:
            <asp:label id="UltimoLote" runat="server" class="font-weight-bold"></asp:label>
            <% }
                else
                { %>
            &nbsp;
            <%
                } %>

            <div class="scroll-box">
                <asp:gridview
                    id="GridItens"
                    runat="server"
                    autogeneratecolumns="false"
                    cssclass="table table-borderless table-sm table-fixed"
                    itemtype="Apcm.Service.Carrinho.CarrinhoItemData"
                    width="100%">
                    <HeaderStyle CssClass="thead-dark" />
                    <Columns>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="sticky-top-left text-center" Width="40px" />
                            <ItemStyle HorizontalAlign="Center" CssClass="sticky-left" />
                            <HeaderTemplate>
                                <asp:CheckBox ID="AlternarSelecao" runat="server" AutoPostBack="true" OnCheckedChanged="AlternarSelecao_CheckedChanged" Enabled='<%# PodeRemover %>' />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="Selecionado" runat="server" Enabled='<%# PodeRemover %>' />
                                <asp:HiddenField ID="IdCarrinhoItem" runat="server" Value='<%# Item.IdCarrinhoItem.ToString() %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="item_nbr" HeaderText="Código do item SAM'S" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="item1_desc" HeaderText="Descrição do item SAM'S" HeaderStyle-CssClass="sticky-top text-center" />
                        <asp:BoundField DataField="codCategoria" HeaderText="Código da Categoria" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="DescrCategoria" HeaderText="Descrição da Categoria" HeaderStyle-CssClass="sticky-top text-center" />
                        <asp:BoundField DataField="codSubcategoria" HeaderText=" Código da Subcategoria" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="DescrSubcategoria" HeaderText=" Descrição da Subcategoria" HeaderStyle-CssClass="sticky-top text-center" />
                    </Columns>
                </asp:gridview>
            </div>
        </div>
    </div>

    <div id="dvGridProdutos" runat="server" class="row tm-2">
        <div class="col">
            <%if (true)
                {%>
             Produtos disponíveis para edição: <span class="font-weight-bold"><%: GridProdutos.Rows.Count.ToString("N0") %></span>
            -
                    Último Lote:

            <asp:label id="UltimoLoteSad" runat="server" class="font-weight-bold"></asp:label>
            <%}
                else
                {%>
            &nbsp;
            <% } %>

            <div class="scroll-box">
                <asp:gridview
                    id="GridProdutos"
                    runat="server"
                    autogeneratecolumns="false"
                    cssclass="table table-borderless table-sm table-fixed"
                    itemtype="Apcm.Service.Carrinho.CarrinhoItemData"
                    width="100%">
                    <HeaderStyle CssClass="thead-dark" />
                    <Columns>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="sticky-top-left text-center" Width="40px" />
                            <ItemStyle HorizontalAlign="Center" CssClass="sticky-left" />
                            <HeaderTemplate>
                                <asp:CheckBox ID="AlternarSelecao" runat="server" AutoPostBack="true" OnCheckedChanged="AlternarSelecao_CheckedChanged" Enabled='<%# PodeRemover %>' />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="Selecionado" runat="server" Enabled='<%# PodeRemover %>' />
                                <asp:HiddenField ID="IdCarrinhoItem" runat="server" Value='<%# Item.IdCarrinhoItem.ToString() %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="produto_nbr" HeaderText="Código do produto SAD" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="item1_desc" HeaderText="Descrição do produto SAD" HeaderStyle-CssClass="sticky-top text-center" />
                        <asp:BoundField DataField="Secao" HeaderText="Seção" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="SecaoDesc" HeaderText="Descrição da Seção" HeaderStyle-CssClass="sticky-top text-center" />
                        <asp:BoundField DataField="Linha" HeaderText="Linha" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="LinhaDesc" HeaderText="Descrição da Linha" HeaderStyle-CssClass="sticky-top text-center" />
                        <asp:BoundField DataField="Sublinha" HeaderText="Sublinha" HeaderStyle-CssClass="sticky-top text-center" ItemStyle-CssClass="text-center" />
                        <asp:BoundField DataField="SublinhaDesc" HeaderText="Descrição da Sublinha" HeaderStyle-CssClass="sticky-top text-center" />
                    </Columns>
                </asp:gridview>
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
                            <asp:label id="RemoverMsg" runat="server"></asp:label>
                        </h5>
                    </div>
                    <div class="modal-footer">
                        <asp:button id="ConfirmarRemover" runat="server" text="Sim" cssclass="btn btn-sm btn-danger" onclick="ConfirmarRemover_Click" />
                        <asp:button id="CancelarRemover" runat="server" text="Não" cssclass="btn btn-sm btn-secondary" onclick="CancelarRemover_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <iframe id="iFrameDownload" runat="server" style="visibility: hidden; width: 0; height: 0;"></iframe>

</asp:Content>
<asp:Content ID="ScriptPlaceHolder" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="module" src="<%: Page.ResolveUrl("~/Content/js/pages/carrinho.js") %>"></script>
</asp:Content>
