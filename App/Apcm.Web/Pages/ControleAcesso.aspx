<%@ Page Title="Controle de Acesso" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="ControleAcesso.aspx.cs" Inherits="Apcm.Web.Pages.ControleAcesso" EnableEventValidation="false" %>

<asp:Content ID="headPlaceHolder" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link type="text/css" rel="stylesheet" href="<%: Page.ResolveUrl("~/Content/css/pages/controleAcesso.css") %>" />
</asp:Content>

<asp:Content ID="bodyPlaceHolder" ContentPlaceHolderID="bodyPlaceHolder" runat="server">
    <asp:UpdatePanel ID="updatePanel" runat="server">
        <ContentTemplate>

            <div class="border-bottom border-secondary p-0 m-0 mb-3">
                <img alt="" src="<%: Page.ResolveUrl("~/Content/images/user-check.svg") %>" class="d-inline-block align-top ml-3 mr-2 header-image" />
                <span class="h4">Controle de Acesso</span>
            </div>

            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">

                        <div class="form-group">
                            <label>Filtro de Pesquisa</label>
                            <asp:HiddenField ID="ModoVisualizacao" runat="server" />
                            <div class="btn-group btn-group-sm w-100 btn-group-md" role="group" aria-label="Modo de visualização">
                                <asp:Button ID="btnTodos" runat="server" CssClass="btn btn-secondary active text-truncate w-50" Text="Todos" OnClick="btnModoVisualizacao" />
                                <asp:Button ID="btnNovos" runat="server" CssClass="btn btn-secondary text-truncate w-50" Text="Novos" OnClick="btnModoVisualizacao" />
                            </div>

                            <div class="btn-group btn-group-sm w-100 btn-group-md" role="group" aria-label="Modo de visualização">
                                <asp:Button ID="btnAdmins" runat="server" CssClass="btn btn-secondary text-truncate w-50" Text="Perfil Admin" OnClick="btnModoVisualizacao" />
                                <asp:Button ID="btnEditores" runat="server" CssClass="btn btn-secondary text-truncate w-50" Text="Perfil Cadastro" OnClick="btnModoVisualizacao" />
                            </div>

                            <div class="btn-group btn-group-sm w-100 btn-group-md" role="group" aria-label="Modo de visualização">
                                <asp:Button ID="btnAtacado" runat="server" CssClass="btn btn-secondary text-truncate w-50" Text="Acesso Sam's" OnClick="btnModoVisualizacao" />
                                <asp:Button ID="btnVarejo" runat="server" CssClass="btn btn-secondary text-truncate w-50" Text="Acesso Varejo" OnClick="btnModoVisualizacao" />
                            </div>

                            <div class="row mt-2 mb-2">
                                <div class="col-md">
                                    <asp:TextBox ID="Pesquisa" runat="server" placeholder="Login (rede ou SAD), nome ou e-mail" MaxLength="100" CssClass="form-control form-control-sm w-100" />
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-md-6">
                                    <p>
                                        <asp:Label ID="TipoFiltro" runat="server">Localizados</asp:Label>:
                            <b>
                                <asp:Label ID="qtdUsuarios" runat="server">0</asp:Label></b>
                                    </p>
                                </div>
                                <div class="col-md align-self-center">
                                    <asp:Button ID="btnPesquisa" runat="server" Text="Localizar" CssClass="btn btn-sm btn-primary w-md-100" OnClick="Localizar" />
                                </div>

                            </div>


                        </div>

                        <hr />

                        <div class="form-group">
                            <label for="LoginUsuario">Cadastro de Usuários</label>
                            <div class="row mt-2 mb-2">
                                <div class="col-md-6">
                                    <asp:TextBox ID="LoginUsuario" runat="server" placeholder="Login de Rede" MaxLength="10" CssClass="form-control form-control-sm " ValidationGroup="preCadastro" />
                                </div>
                                <div class="col-md-6">
                                    <asp:TextBox ID="LoginSad" runat="server" placeholder="Login SAD" MaxLength="10" CssClass="form-control form-control-sm " ValidationGroup="preCadastro" />
                                </div>
                            </div>
                            <div class="row mt-2 mb-2">
                                <div class="col-md-6">
                                    <asp:CheckBox ID="UsuarioAdmin" runat="server" Text="" />
                                    <asp:Label runat="server" AssociatedControlID="UsuarioAdmin" CssClass="form-check-label">Perfil Admin</asp:Label>
                                    <br />
                                    <asp:CheckBox ID="UsuarioEditor" runat="server" Text="" />
                                    <asp:Label runat="server" AssociatedControlID="UsuarioEditor" CssClass="form-check-label">Perfil Cadastro</asp:Label>
                                    <br />
                                    <asp:CheckBox ID="UsuarioAtacado" runat="server" Text="" />
                                    <asp:Label runat="server" AssociatedControlID="UsuarioAtacado" CssClass="form-check-label">Acesso Sam's</asp:Label>
                                    <br />
                                    <asp:CheckBox ID="UsuarioVarejo" runat="server" Text="" />
                                    <asp:Label runat="server" AssociatedControlID="UsuarioVarejo" CssClass="form-check-label">Acesso Varejo</asp:Label>
                                </div>
                                <div class="col-md align-self-center">
                                    <asp:Button ID="btnAdicionar" runat="server" Text="Incluir" CssClass="btn btn-sm btn-primary w-md-100" ValidationGroup="preCadastro" OnClick="btnAdicionar_Click" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <asp:RequiredFieldValidator ID="rfvLoginUsuario" runat="server" ControlToValidate="LoginUsuario" ValidationGroup="preCadastro" Text="" ErrorMessage="Informe o Login de Rede!" CssClass="text-danger small"></asp:RequiredFieldValidator>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvLoginSad" runat="server" ControlToValidate="LoginSad" ValidationGroup="preCadastro" Text="" ErrorMessage="Informe o Login SAD!" CssClass="text-danger small"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="col-md-9">

                        <div class="scroll-box w-100">
                            <asp:GridView
                                ID="GridView"
                                runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table table-borderless table-sm table-fixed table-striped table-hover"
                                EmptyDataText="Nenhum Usuário Localizado!"
                                OnRowDataBound="GridView_RowDataBound" >
                                <HeaderStyle CssClass="thead-dark" />
                                <Columns>
                                    <asp:BoundField HeaderText="Login Rede" DataField="Login" HeaderStyle-CssClass="sticky-top" />
                                    <asp:BoundField HeaderText="Nome" DataField="Nome" HeaderStyle-CssClass="sticky-top" />
                                    <asp:BoundField HeaderText="E-Mail" DataField="Email" HeaderStyle-CssClass="sticky-top" />

                                    <asp:TemplateField HeaderText="Login SAD">
                                        <HeaderStyle CssClass="text-center sticky-top" />
                                        <ItemStyle HorizontalAlign="Center" CssClass="td-p-0" />
                                        <ItemTemplate>
                                            <asp:HiddenField ID="HdnLoginSad" runat="server" Value='<%# Eval("LoginSad") %>' />
                                            <asp:TextBox ID="LoginSad" runat="server" Text='<%# Eval("LoginSad") %>' CssClass="form-control form-control-sm text-center" MaxLength="10" AutoPostBack="true" OnTextChanged="LoginSad_TextChanged"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Perfil Admin">
                                        <HeaderStyle CssClass="text-center sticky-top" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="Admin" runat="server" Text="" Checked='<%# Convert.ToBoolean(Eval("Admin")) %>' OnCheckedChanged="AdminEditor_CheckedChanged" AutoPostBack="true" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Perfil Cadastro">
                                        <HeaderStyle CssClass="text-center sticky-top" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="Editor" runat="server" Text="" Checked='<%# Convert.ToBoolean(Eval("Editor")) %>' OnCheckedChanged="AdminEditor_CheckedChanged" AutoPostBack="true" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Acesso Sam's">
                                        <HeaderStyle CssClass="text-center sticky-top" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="Atacado" runat="server" Text="" Checked='<%# Convert.ToBoolean(Eval("Atacado")) %>' OnCheckedChanged="AdminEditor_CheckedChanged" AutoPostBack="true" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Acesso Varejo">
                                        <HeaderStyle CssClass="text-center sticky-top" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="Varejo" runat="server" Text="" Checked='<%# Convert.ToBoolean(Eval("Varejo")) %>' OnCheckedChanged="AdminEditor_CheckedChanged" AutoPostBack="true" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <HeaderStyle CssClass="sticky-top" />
                                        <ItemTemplate>
                                                <asp:ImageButton
                                                    ID="ExibirExcluir"
                                                    runat="server"
                                                    AlternateText=""
                                                    ImageUrl="~/Content/images/trash-2.svg"
                                                    Style="width: 20px; height: 20px;"
                                                    OnClick="ExibirExcluir_Click"
                                                    
                                                    />
                                        </ItemTemplate>
                                    </asp:TemplateField>
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

            <div id="ModalExcluir" runat="server" visible="false">
                <div class="modal-backdrop show"></div>
                <div class="modal" style="display: block">
                    <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    Confirma a exclusão de <b><asp:Label ID="LoginExclusao" runat="server"></asp:Label></b>?
                                </h5>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="ConfirmarExcluir" runat="server" Text="Sim" CssClass="btn btn-sm btn-danger" OnClick="ConfirmarExcluir_Click" />
                                <asp:Button ID="CancelarExcluir" runat="server" Text="Não" CssClass="btn btn-sm btn-secondary" OnClick="CancelarExcluir_Click" />                                                        
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="scriptPlaceHolder" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="text/javascript" src="<%: Page.ResolveUrl("~/Content/js/pages/controleAcesso.js") %>"></script>
</asp:Content>

