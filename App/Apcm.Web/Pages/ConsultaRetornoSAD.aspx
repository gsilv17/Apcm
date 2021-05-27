<%@ Page Title="Consulta Retorno SAD" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="ConsultaRetornoSAD.aspx.cs" Inherits="Apcm.Web.Pages.ConsultaRetornoSAD" EnableEventValidation="false" %>

<asp:Content ID="headPlaceHolder" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="<%: Page.ResolveUrl("~/Content/css/pages/controleAcesso.css") %>" />
</asp:Content>

<asp:Content ID="bodyPlaceHolder" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:UpdatePanel ID="updatePanel" runat="server">
        <ContentTemplate>

            <div class="border-bottom border-secondary p-0 m-0 mb-3">
                <img alt="" src="../Content/images/user-check.svg" class="d-inline-block align-top ml-3 mr-2 header-image" />
                <span class="h4">Pesquisa de Itens Enviados - <%: PageParameters.CodSistema == "Atacado" ? "Sam's" : "Varejo" %></span>
            </div>

            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Filtros de Pesquisa</label>
                            <asp:HiddenField ID="ModoVisualizacao" runat="server" />

                            <div class="row mt-2 mb-2">
                                <div class="col-md-4">
                                    <asp:Label ID="lbLogin" Text="Login" runat="server" />
                                </div>
                                <div class="col-md-8">
                                    <asp:TextBox ID="Pesquisa" runat="server" placeholder="Login (rede ou SAD)" MaxLength="100" CssClass="form-control form-control-sm w-100" />
                                </div>
                            </div>
                            <div class="row mt-3 mb-3">
                                <div class="col-md-4">
                                    <asp:Label ID="lbLote" Text="Lote" runat="server" />
                                </div>
                                <div class="col-md-8">
                                    <asp:TextBox ID="txtIdLote" runat="server" placeholder="Lote" MaxLength="100" CssClass="form-control form-control-sm w-100" />
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-md-4">
                                    <asp:Label ID="lbStatus" Text="Status Lote" runat="server" />
                                </div>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlStatusLote" runat="server"  placeholder="Status Lote" CssClass="form-control form-control-sm w-100" AutoPostBack="true">
                                        <asp:ListItem Selected="True" Value="">Todos</asp:ListItem>
                                        <asp:ListItem Value="1">Processado</asp:ListItem>
                                        <asp:ListItem Value="2">Não Processado</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-md-4">
                                    <asp:Label ID="lbStatusItem" Text="Msg Retorno" runat="server" />
                                </div>
                                <div class="col-md-8">
                                    <asp:DropDownList ID="ddlStatusRetornoItem" runat="server"  placeholder="Status Retorno Item" CssClass="form-control form-control-sm w-100" AutoPostBack="true">
                                        <asp:ListItem Selected="True" Value="">Todos</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-md align-self-center">
                                    <asp:Button ID="btnPesquisa" runat="server" Text="Localizar" CssClass="btn btn-sm btn-primary w-md-100" OnClick="Localizar" />
                                </div>
                                <div class="col-md align-self-center">
                                    <asp:Button ID="btnExportar" runat="server" Text="Exportar" CssClass="btn btn-sm btn-primary w-md-100" OnClick="Exportar" />
                                </div>
                            </div>
                        </div>
                         <div class="col-sm-8 pb-1">
                            <asp:HiddenField ID="AlertMsg" runat="server" />
                            <asp:HiddenField ID="AlertType" runat="server" />
                            <%if (!string.IsNullOrEmpty(AlertMsg.Value))
                                { %>
                            <label class='alert alert-sm w-100 <%: AlertType.Value %>'><%: AlertMsg.Value %></label>
                            <%} %>
                        </div>
                        <hr />
                    </div>

                    <div class="col-md-9">

                        <div class="scroll-box w-100">
                            <asp:GridView
                                ID="GridView"
                                runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table table-borderless table-sm table-fixed table-striped table-hover"
                                EmptyDataText="Nenhum Lote Localizado!"
                                 OnRowDataBound="GridView_RowDataBound">
                                <HeaderStyle CssClass="thead-dark" />
                                <Columns>
                                    <asp:BoundField HeaderText="Lote" DataField="Lote" HeaderStyle-CssClass="sticky-top" />
                                    <asp:BoundField HeaderText="Usuário" DataField="Usuario" HeaderStyle-CssClass="sticky-top" />
                                    <asp:BoundField HeaderText="Cód. Item Link" DataField="CodItemLink" HeaderStyle-CssClass="sticky-top" />
                                    <asp:BoundField HeaderText="Cod Produto SAD" DataField="CodProdutoSAD" HeaderStyle-CssClass="sticky-top" />
                                    <asp:BoundField HeaderText="Status do Lote" DataField="StatusRetornoLote" HeaderStyle-CssClass="sticky-top" />
                                    <asp:BoundField HeaderText="Mensagem de Retorno" DataField="StatusRetorno" HeaderStyle-CssClass="sticky-top" />
                                    <asp:BoundField HeaderText="Data de Envio" DataField="DataEnvio" HeaderStyle-CssClass="sticky-top" />
                                </Columns>
                            </asp:GridView>
                        </div>

                    </div>

                </div>
            </div>

            <div class="modal fade" id="modalAlerta" tabindex="-1" role="dialog" aria-labelledby="modalAlertaLabel" aria-hidden="true" runat="server">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalAlertaLabel">
                                <asp:Label ID="modalAlertaTitulo" runat="server"></asp:Label>
                            </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="modalAlertaMensagem" runat="server"></asp:Label>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>

            <iframe id="iFrameDownload" runat="server" style="visibility: hidden; width: 0; height: 0;"></iframe>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>