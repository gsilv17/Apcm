<%@ Page Title="Edição e Envio de Itens" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="EdicaoEnvioItens.aspx.cs" Inherits="TSamsF3.Web.Pages.EdicaoEnvioItens" EnableEventValidation="false" %>

<asp:Content ID="headPlaceHolder" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="../Content/css/pages/edicaoEnvioItens.css" />
    
</asp:Content>

<asp:Content ID="bodyPlaceHolder" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:UpdatePanel ID="updatePanel" runat="server">
        <ContentTemplate>

            <div class="border-bottom border-secondary p-0 m-0 mb-3">
                <img alt="" src="../Content/images/edit.svg" class="d-inline-block align-top ml-3 mr-2 header-image" />
                <span class="h4">Edição e Envio de Itens</span>
            </div>

            <div class="row">
                <div class="col-6 col-sm-2 m-sm-0">
                    <asp:Button ID="btnModelo" runat="server" Text="Modelo" CssClass="btn btn-secondary btn-sm w-100 text-truncate" OnClick="btnModelo_Click" />
                </div>
                <div class="col-6 col-sm-2 m-sm-0">
                    <asp:Button ID="btnReplicar" runat="server" Text="Replicar Modelo" CssClass="btn btn-secondary btn-sm w-100 text-truncate" OnClick="btnReplicar_Click" />
                </div>

                <div class="col-4 col-sm-2 m-sm-0">
                    <asp:Button ID="AbrirModalXls" runat="server" Text="Excel" CssClass="btn btn-secondary btn-sm w-100 text-truncate j-menu-lnk" OnClick="AbrirModalXls_Click" />
                </div>

                <div class="col-12 col-sm-8 mt-3 mt-sm-auto">
                    <asp:HiddenField ID="AlertType" runat="server" />
                    <asp:HiddenField ID="AlertMsg" runat="server" />
                    <div class="alert alert-sm w-100 <%: AlertType.Value %> <%: string.IsNullOrEmpty(AlertMsg.Value) ? "d-none" : "" %>" role="alert">
                        <%: AlertMsg.Value %>
                    </div>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col">
                    <div id="ScrollBox" runat="server" class="scroll-box">
                        <asp:GridView
                            ID="GridItens"
                            runat="server"
                            AutoGenerateColumns="false"
                            CssClass="table table-borderless table-sm table-fixed"
                            Width="2150"
                            OnRowDataBound="GridItens_RowDataBound">
                            <HeaderStyle CssClass="thead-dark" />

                            <Columns>

                                <asp:TemplateField>
                                    <ItemStyle HorizontalAlign="Center" CssClass="sticky-left item-select" />
                                    <HeaderStyle CssClass="sticky-top-left text-center" Width="50px" />
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="AlternarSelecionadoCarrinho" runat="server" AutoPostBack="true" OnCheckedChanged="AlternarSelecionadoCarrinho_CheckedChanged" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:HiddenField ID="IdCarrinho" runat="server" Value='<%# Eval("idCarrinho") %>' />
                                        <asp:HiddenField ID="IdLoad" runat="server" Value='<%# Eval("idLoad") %>' />
                                        <asp:HiddenField ID="Enviado" runat="server" Value='<%# Eval("enviado") %>' />
                                        <asp:CheckBox ID="Selecionado" runat="server" Value='<%# Eval("selecionado") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <HeaderStyle CssClass="sticky-top-left sticky-top-left-2 text-center" Width="50px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Bottom" CssClass="sticky-left sticky-left-2 item-btn" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="BtnEnviar" runat="server" AlternateText="" ImageUrl="~/Content/images/send.svg" CssClass="btn-img" OnClick="BtnEnviar_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField
                                    DataField="item_nbr"
                                    HeaderText="Item"
                                    HeaderStyle-CssClass="sticky-top-left sticky-top-left-3 text-center"
                                    HeaderStyle-Width="100px"
                                    ItemStyle-HorizontalAlign="Center"
                                    ItemStyle-CssClass="sticky-left sticky-left-3" />

                                <asp:TemplateField HeaderText="Produto">
                                    <HeaderStyle CssClass="sticky-top-left sticky-top-left-4 text-center" Width="100px" />
                                    <ItemStyle CssClass="sticky-left sticky-left-4" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="produto_nbr" runat="server" Text='<%# ((int)Eval("produto_nbr")) == 0 ? string.Empty : Eval("produto_nbr") %>' CssClass="form-control form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Descrição">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="item1_desc" runat="server" Text='<%# Eval("item1_desc") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="UPC">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="upc_nbr" runat="server" Text='<%# Eval("upc_nbr") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Signing 1 Desc">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="signing_desc" runat="server" Text='<%# Eval("signing_desc") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Orderable Qty">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="vnpk_qty" runat="server" Text='<%# Eval("vnpk_qty") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Orderable GTIN">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="case_upc_nbr" runat="server" Text='<%# Eval("case_upc_nbr") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Supplier Stock Id">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="vendor_stock_id" runat="server" Text='<%# Eval("vendor_stock_id") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Supplier Pack Cost">
                                    <HeaderStyle CssClass="sticky-top" Width="200px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="vnpk_cost_amt" runat="server" Text='<%# Eval("vnpk_cost_amt") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Orderable Depth">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="item_length_qty" runat="server" Text='<%# Eval("item_length_qty") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Orderable Width">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="item_width_qty" runat="server" Text='<%# Eval("item_width_qty") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Orderable Height">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="item_height_qty" runat="server" Text='<%# Eval("item_height_qty") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Variance days">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="min_rcvng_days_qty" runat="server" Text='<%# Eval("min_rcvng_days_qty") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="IPI Stamp Class">
                                    <HeaderStyle CssClass="sticky-top" Width="150px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="ipi_tax_class_cd" runat="server" Text='<%# Eval("ipi_tax_class_cd") %>' CssClass="form-control form-control-sm form-control-xsm"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>

                            <%-- 
                                Tamanho dos campos
                                45+45+80+90+(150*12)
                            --%>
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <div class="row pr-2 m-1">
                <div class="col text-right small">
                    Itens no carrinho: <%: GridItens.Rows.Count.ToString("N0", new System.Globalization.CultureInfo("pt-br")) %>
                </div>
            </div>

            <label id="AlertEnvioOk" runat="server" class="'alert alert-sm w-100 alert-success" visible="false">
                O item
                <%: ItemNbr %>
                foi enviado com sucesso!
            </label>

            <label id="AlertEnvioErro" runat="server" class="'alert alert-sm w-100 alert-danger" visible="false">
                O item
                <%: ItemNbr %>
                não foi enviado!<br />
                <asp:Label ID="MsgAlertEnvioErro" runat="server"></asp:Label>
            </label>

            <div id="AlertErroValidacao" class="alert alert-danger" runat="server" visible="false">
                Existem erros de validação para o Item <span class="alert-link">
                    <%: ItemNbr %>
                </span>
                <asp:Button ID="FecharAlertErroValidacao" runat="server" CssClass="close" Text="&times;" OnClick="FecharAlertErroValidacao_Click" />
                <div class="scroll-box scroll-box-alert mt-1">
                    <asp:Repeater ID="RepeaterErroValidacao" runat="server">
                        <ItemTemplate>
                            <div class="row">
                                <div class="col-2 pl-4">
                                    <b><%# Eval("Descricao") %></b>
                                </div>
                                <div class="col">
                                    <%# Eval("Erro") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div id="ModalConfirmarEnvio" runat="server" visible="false">
                <div class="modal-backdrop show"></div>
                <div class="modal" style="display: block">
                    <div class="modal-dialog modal-dialog-centered modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Confirma o envio do item
                                        <b><%: ItemNbr %></b>?
                                </h5>
                            </div>
                            <div class="modal-body">
                                O item será validado antes do envio, possíveis erros serão apresentados.
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="ValidarEnviar" runat="server" CssClass="btn btn-sm btn-primary" OnClick="ValidarEnviar_Click" Text="Sim" />
                                <asp:Button ID="CancelarValidarEnviar" runat="server" CssClass="btn btn-sm btn-secondary" OnClick="CancelarValidarEnviar_Click" Text="Não" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="ModalEnviado" runat="server" visible="false">
                <div class="modal-backdrop show"></div>
                <div class="modal" style="display: block">
                    <div class="modal-dialog modal-dialog-centered modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">O Item 
                                        <b><%: ItemNbr %></b>
                                    já foi enviado.
                                </h5>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="BtnFecharModalEnviado" runat="server" CssClass="btn btn-sm btn-primary" OnClick="BtnFecharModalEnviado_Click" Text="Ok" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="ModalXls" runat="server" visible="false">
                <div class="modal-backdrop show"></div>
                <div class="modal" style="display: block">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Exportação e Importação
                                </h5>
                            </div>
                            <div class="modal-body">
                                <div class="row mb-3 mt-3">
                                    <div class="col">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <asp:Button ID="Exportar" runat="server" Text="Exportar" CssClass="btn btn-secondary w-100" OnClick="Exportar_Click" />
                                            </div>
                                            <div class="custom-file">
                                                <asp:FileUpload ID="FileUpXls" runat="server" CssClass="custom-file-input" />
                                                <label id="fileUpXlsLabel" class="custom-file-label" for="<%: FileUpXls.ClientID %>" data-browse="Selecionar">Selecione um arquivo...</label>
                                            </div>
                                            <div class="input-group-append">
                                                <asp:Button ID="Importar" runat="server" CssClass="btn btn-secondary" Text="Importar" OnClick="Importar_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <div id="ModalXls_Alert" runat="server" />
                                    </div>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="FecharModalXls" runat="server" CssClass="btn btn-secondary btn-large" OnClick="FecharModalXls_Click" Text="Fechar" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="ModalModelo" runat="server" visible="false">
                <div class="modal-backdrop show"></div>
                <div class="modal" style="display: block">
                    <div class="modal-dialog modal-xl" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalModeloTitle">Modelo de dados</h5>
                            </div>
                            <div class="modal-body">
                                <div class="scroll-box">
                                    <div class="container-fluid">

                                        <div class="form-row">
                                            <div class="col-sm-2 form-group">
                                                <label for="produto_nbr">Cod. Produto</label>
                                                <asp:TextBox ID="produto_nbr" runat="server" Text="<%# Modelo.produto_nbr == 0 ? string.Empty : Modelo.produto_nbr.ToString() %>" CssClass="form-control form-control-sm" MaxLength="10"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revProduto_nbr" runat="server" ControlToValidate="produto_nbr" Text="Somente Números" ValidationExpression="^\d+$" ValidationGroup="vgModelo" EnableClientScript="true" CssClass="small text-danger" />
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for="item1_desc">Descrição</label>
                                                <asp:TextBox ID="item1_desc" runat="server" Text="<%# Modelo.item1_desc %>" MaxLength="30" CssClass="form-control form-control-sm"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for="upc_nbr">UPC</label>
                                                <asp:TextBox ID="upc_nbr" runat="server" Text='<%# Modelo.upc_nbr == 0 ? string.Empty : Modelo.upc_nbr.ToString() %>' CssClass="form-control form-control-sm" MaxLength="10"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revUpc_nbr" runat="server" ControlToValidate="upc_nbr" Text="Somente Números" ValidationExpression="^\d{1,15}$" ValidationGroup="vgModelo" EnableClientScript="true" CssClass="small text-danger" />
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for="signing_desc">Signing 1 Desc</label>
                                                <asp:TextBox ID="signing_desc" runat="server" Text='<%# Modelo.signing_desc %>' MaxLength="40" CssClass="form-control form-control-sm"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for="vnpk_qty">Orderable Qty</label>
                                                <asp:TextBox ID="vnpk_qty" runat="server" Text='<%# Modelo.vnpk_qty %>' CssClass="form-control form-control-sm"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="rev_Vnpk_qty" runat="server" ControlToValidate="vnpk_qty" Text="Somente Números" ValidationExpression="^\d{1,9}$" ValidationGroup="vgModelo" EnableClientScript="true" CssClass="small text-danger" />
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for="case_upc_nbr">Orderable GTIN</label>
                                                <asp:TextBox ID="case_upc_nbr" runat="server" Text='<%# Modelo.case_upc_nbr %>' CssClass="form-control form-control-sm"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="rev_case_upc_nbr" runat="server" ControlToValidate="case_upc_nbr" Text="Somente Números" ValidationExpression="^\d{1,15}$" ValidationGroup="vgModelo" EnableClientScript="true" CssClass="small text-danger" />
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="col-sm-2 form-group">
                                                <label for="vendor_stock_id">Supplier Stock Id</label>
                                                <asp:TextBox ID="vendor_stock_id" runat="server" Text='<%# Modelo.vendor_stock_id %>' CssClass="form-control form-control-sm"></asp:TextBox>

                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for="vnpk_cost_amt">Supplier Pack Cost</label>
                                                <asp:TextBox ID="vnpk_cost_amt" runat="server" Text='<%# Modelo.vnpk_cost_amt %>' CssClass="form-control form-control-sm"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="rev_vnpk_cost_amt" runat="server" ControlToValidate="vnpk_cost_amt" Text="Somente Números (decimal)" ValidationExpression="^(\d{1,9}$|\d{1,9},\d{1,4})$" ValidationGroup="vgModelo" EnableClientScript="true" CssClass="small text-danger" />
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for="item_length_qty">Orderable Depth</label>
                                                <asp:TextBox ID="item_length_qty" runat="server" Text='<%# Modelo.item_length_qty %>' CssClass="form-control form-control-sm"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="rev_item_length_qty" runat="server" ControlToValidate="item_length_qty" Text="Somente Números (decimal)" ValidationExpression="^(\d{1,6}$|\d{1,6},\d{1,3})$" ValidationGroup="vgModelo" EnableClientScript="true" CssClass="small text-danger" />
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for="item_width_qty">Orderable Width</label>
                                                <asp:TextBox ID="item_width_qty" runat="server" Text='<%# Modelo.item_width_qty %>' CssClass="form-control form-control-sm" MaxLength="20"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="rev_item_width_qty" runat="server" ControlToValidate="item_width_qty" Text="Somente Números (decimal)" ValidationExpression="^(\d{1,6}$|\d{1,6},\d{1,3})$" ValidationGroup="vgModelo" EnableClientScript="true" CssClass="small text-danger" />
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for="item_height_qty">Orderable Height</label>
                                                <asp:TextBox ID="item_height_qty" runat="server" Text='<%# Modelo.item_height_qty %>' CssClass="form-control form-control-sm" MaxLength="20"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="rev_item_height_qty" runat="server" ControlToValidate="item_height_qty" Text="Somente Números (decimal)" ValidationExpression="^(\d{1,6}$|\d{1,6},\d{1,3})$" ValidationGroup="vgModelo" EnableClientScript="true" CssClass="small text-danger" />
                                                
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for="min_rcvng_days_qty">Variance days</label>
                                                <asp:TextBox ID="min_rcvng_days_qty" runat="server" Text='<%# Modelo.min_rcvng_days_qty %>' CssClass="form-control form-control-sm"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="rev_min_rcvng_days_qty" runat="server" ControlToValidate="min_rcvng_days_qty" Text="Somente Números" ValidationExpression="^\d+$" ValidationGroup="vgModelo" EnableClientScript="true" CssClass="small text-danger" />
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="col-sm-2 form-group">
                                                <label for="ipi_tax_class_cd">IPI Stamp Class</label>
                                                <asp:TextBox ID="ipi_tax_class_cd" runat="server" Text='<%# Modelo.ipi_tax_class_cd %>' CssClass="form-control form-control-sm"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="rev_ipi_tax_class_cd" runat="server" ControlToValidate="ipi_tax_class_cd" Text="Somente Números" ValidationExpression="^\d+$" ValidationGroup="vgModelo" EnableClientScript="true" CssClass="small text-danger" />
                                            </div>
                                            <%--<div class="col-sm-2 form-group">
                                                <label for=""></label>
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for=""></label>

                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for=""></label>

                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for=""></label>

                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for=""></label>

                                            </div> --%>
                                        </div>

                                        <%--<div class="form-row">
                                            <div class="col-sm-2 form-group">
                                                <label for=""></label>
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for=""></label>
                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for=""></label>

                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for=""></label>

                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for=""></label>

                                            </div>
                                            <div class="col-sm-2 form-group">
                                                <label for=""></label>

                                            </div> 
                                        </div>--%>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <span class="small text-muted">Os dados do modelo são mantidos temporariamente!
                                </span>
                                <asp:Button ID="SalvarModelo" runat="server" Text="Salvar" CssClass="btn btn-primary btn-sm btn-large" OnClick="SalvarModelo_Click" />
                                <asp:Button ID="CancelarModelo" runat="server" Text="Cancelar" CssClass="btn btn-secondary btn-sm btn-large" OnClick="CancelarModelo_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <iframe id="iFrameDownload" runat="server" style="visibility: hidden; width: 0; height: 0;"></iframe>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="Importar" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="scriptPlaceHolder" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="module" src="<%: Page.ResolveUrl("~/Content/js/pages/edicaoEnvioItens.js") %>"></script>
</asp:Content>
