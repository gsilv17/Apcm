<%@ Page Title="Consulta de Lotes" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="ConsultaLotes.aspx.cs" Inherits="Apcm.Web.Pages.ConsultaLotes" EnableEventValidation="false" %>

<asp:Content ID="HeadPlaceHolder" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="<%: Page.ResolveUrl("~/Content/css/pages/consultaLotes.css") %>" />
</asp:Content>
<asp:Content ID="BodyPlaceHolder" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:UpdatePanel ID="UpdatePanel" runat="server">
        <ContentTemplate>
            <div class="border-bottom border-secondary p-0 m-0 mb-3">
                <img alt="" src="<%: Page.ResolveUrl("~/Content/images/search.svg") %>" class="d-inline-block align-top ml-3 mr-2 header-image" />
                <span class="h4">Consulta de Lotes - <%: PageParameters.CodSistema == "Atacado" ? "Sam's" : "Varejo" %></span>
            </div>

            <div class="form-row">
                <div class="col-2">
                    <asp:Label AssociatedControlID="Usuario" runat="server">Login</asp:Label>
                    <asp:TextBox ID="Usuario" runat="server" CssClass="form-control form-control-sm" MaxLength="10" placeholder="Login, matrícula ou nome."></asp:TextBox>
                </div>
                <div class="col-2">
                    <asp:Label AssociatedControlID="NumeroLote" runat="server">Número do Lote</asp:Label>
                    <asp:TextBox ID="NumeroLote" runat="server" CssClass="form-control form-control-sm ts-input-numerico" MaxLength="17" placeholder="Número do lote"></asp:TextBox>
                </div>

                <div class="col-2">
                    <asp:Label AssociatedControlID="StatusLote" runat="server">Situação do Lote</asp:Label>
                    <asp:DropDownList ID="StatusLote" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true" OnTextChanged="StatusLote_TextChanged">
                        <asp:ListItem Value="-1" Text="Todos" Selected="True" />
                        <asp:ListItem Value="1" Text="Processado" />
                        <asp:ListItem Value="0" Text="Não processado" />
                    </asp:DropDownList>
                </div>

                <div class="col-2">
                    <asp:Label AssociatedControlID="CodOrigem" runat="server">Tipo do Carrinho</asp:Label>
                    <asp:DropDownList ID="CodOrigem" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true" OnTextChanged="CodOrigem_TextChanged">
                        <asp:ListItem Value="" Text="Todos" Selected="True" />
                        <asp:ListItem Value="Sams" Text="Transformação Sams" />
                        <asp:ListItem Value="Sad" Text="Manutenção Massiva" />
                        <asp:ListItem Value="Novo" Text="Novos Produtos" />
                    </asp:DropDownList>
                </div>
            
                <div class="col-3">
                    <asp:Label AssociatedControlID="DataDe" runat="server">Período</asp:Label>
                    <div class="input-group input-group-sm ts-input-datepicker input-daterange">
                        <div class="input-group-prepend">
                            <span class="input-group-text">de</span>
                        </div>
                        <asp:TextBox ID="DataDe" runat="server" CssClass="form-control" autocomplete="chrome-off" AutoPostBack="true" OnTextChanged="DataDe_TextChanged"></asp:TextBox>
                        <div class="input-group-prepend input-group-append">
                            <span class="input-group-text">até</span>
                        </div>
                        <asp:TextBox ID="DataAte" runat="server" CssClass="form-control" autocomplete="chrome-off" AutoPostBack="true" OnTextChanged="DataAte_TextChanged"></asp:TextBox>
                    </div>
                </div>

                               

            </div>

            <div class="form-row mt-2">
                
                <div class="col-4">
                    <asp:Label AssociatedControlID="StatusItem" runat="server">Situação do Item</asp:Label>
                    <asp:DropDownList ID="StatusItem" runat="server" CssClass="form-control form-control-sm" DataTextField="Value" DataValueField="Key"></asp:DropDownList>
                </div>

                <div class="col-1 align-self-end">
                    <asp:Button ID="Pesquisar" runat="server" Text="Pesquisar" OnClick="Pesquisar_Click" CssClass="btn btn-sm btn-primary w-100" />
                </div>
                <div class="col-1 align-self-end">
                    <asp:Button ID="Limpar" runat="server" Text="Limpar" OnClick="Limpar_Click" CssClass="btn btn-sm btn-secondary w-100" />
                </div>
                <div class="col-1 align-self-end">
                    <asp:Button ID="Exportar" runat="server" Text="Exportar" OnClick="Exportar_Click" CssClass="btn btn-sm btn-info w-100 ts-modal-espera-click" />
                </div>
                                
                <div class="col-5 align-self-end">
                    <asp:HiddenField ID="AlertMsg" runat="server" Value="Teste" />
                    <asp:HiddenField ID="AlertType" runat="server" Value="alert-info" />
                    <%if (!string.IsNullOrEmpty(AlertMsg.Value))
                        { %>
                    <label class='alert alert-sm w-100 <%: AlertType.Value %>'><%: AlertMsg.Value %></label>
                    <%} %>
                </div>

            </div>
            
            <div class="row mt-3">
                <div class="col">
                    Itens Localizados: <asp:Label ID="ItensLocalizados" runat="server" CssClass="font-weight-bold" />
                    <div class="scroll-box">
                        <asp:GridView
                            ID="GridLote"
                            runat="server"
                            AutoGenerateColumns="false"
                            CssClass="table table-borderless table-sm table-fixed"
                            ItemType="Apcm.Service.Lote.RetornoPesquisaLote">
                            <HeaderStyle CssClass="thead-dark" HorizontalAlign="Center" />
                            <Columns>
                                <asp:BoundField DataField="IdCarrinho" HeaderText="Carrinho" HeaderStyle-CssClass="sticky-top" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="TipoCarrinho" HeaderText="Tipo de Carrinho" HeaderStyle-CssClass="sticky-top" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="NumeroLote" HeaderText="Lote" HeaderStyle-CssClass="sticky-top" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Login" HeaderText="Login" HeaderStyle-CssClass="sticky-top" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Nome" HeaderText="Usuário" HeaderStyle-CssClass="sticky-top" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="produto_nbr" HeaderText="Cód. Produto" HeaderStyle-CssClass="sticky-top" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="StatusLote" HeaderText="Situação do Lote" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="StatusItem" HeaderText="Situação do Item" HeaderStyle-CssClass="sticky-top" />
                                <asp:BoundField DataField="DhEnvio" HeaderText="Data e Hora do Envio" HeaderStyle-CssClass="sticky-top" ItemStyle-HorizontalAlign="Center" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <iframe id="iFrameDownload" runat="server" style="visibility: hidden; width: 0; height: 0;"></iframe>

        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>
<asp:Content ID="ScriptPlaceHolder" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="module" src="<%: Page.ResolveUrl("~/Content/js/pages/ConsultaLotes.js") %>"></script>
</asp:Content>
