<%@ Page Title="Home" Language="C#" MasterPageFile="~/Pages/Layout/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Apcm.Web.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bodyPlaceHolder" runat="server">

    <h1 class="display-4 text-muted text-center">Ferramenta de cadastro e manutenção massiva de produtos</h1>

    <div class="row mt-4" id="dvSemPerfil" runat="server">
        <div class="col">
            <div class="card text-dark">
                <div class="card-header text-center">
                    <div class="font-weight-bold">
                        Usuário sem Perfil.
                    </div>
                </div>
                <div class="card-body text-center">
                    Você não possui um perfil cadastrado para esta aplicação.
                </div>
            </div>
        </div>
    </div>

    <div id="dvCard" runat="server">


        <%--<div class="row mt-4 align-items-center justify-content-center">
            
            
            <div class="col-6">
                <div class="card text-dark">
                    <div class="card-header text-center">
                        <div class="font-weight-bold">
                            Itens com Cross
                        </div>
                    </div>
                    <div class="card-body text-center">
                        <asp:Label ID="CardComCrossPecent" runat="server" CssClass="font-weight-bold h1"></asp:Label>
                        <br />
                        <asp:Label ID="CardComCrossQtd" runat="server"></asp:Label>
                    </div>
                    <div class="card-footer text-right">
                        <asp:ImageButton ID="DownloadComCross" runat="server" ImageUrl="~/Content/images/download.svg" AlternateText="Download" OnClick="DownloadComCross_Click" CssClass="ts-modal-espera-click" />
                    </div>
                </div>
            </div>
            
            
            <div class="col-6">
                <div class="card text-dark">
                    <div class="card-header text-center">
                        <div class="font-weight-bold">
                            Itens sem Cross
                        </div>
                    </div>
                    <div class="card-body text-center">
                        <asp:Label ID="CardCrossPercent" runat="server" CssClass="font-weight-bold h1"></asp:Label>
                        <br />
                        <asp:Label ID="CardCrossQtd" runat="server"></asp:Label>
                    </div>
                    <div class="card-footer text-right">
                        <asp:ImageButton ID="DownloadCross" runat="server" ImageUrl="~/Content/images/download.svg" AlternateText="Download" OnClick="DownloadCross_Click" CssClass="ts-modal-espera-click" />
                    </div>
                </div>
            </div>

            

        </div>--%>

        <div class="row mt-4 align-items-center justify-content-center">

            <div class="col-6">
                <div class="card text-dark ">
                    <div class="card-header text-center">
                        <div class="font-weight-bold">
                            Itens com Erros
                        </div>
                    </div>
                    <div class="card-body text-center">
                        <asp:Label ID="CardProcessamentoSadPercent" runat="server" CssClass="font-weight-bold h1"></asp:Label>
                        <br />
                        <asp:Label ID="CardProcessamentoSadQtd" runat="server"></asp:Label>
                    </div>
                    <div class="card-footer text-right">
                        <asp:ImageButton ID="DownloadErro" runat="server" ImageUrl="~/Content/images/download.svg" AlternateText="Download" OnClick="DownloadErro_Click" CssClass="ts-modal-espera-click" />
                    </div>
                </div>
            </div>

            <%--<div class="col-6">
                <div class="card text-dark ">
                    <div class="card-header text-center">
                        <div class="font-weight-bold">
                            Gestão de Carrinhos
                        </div>
                    </div>
                    <div class="card-body text-center">
                        <asp:Label ID="CardCarrinhosPercent" runat="server" CssClass="font-weight-bold h1"></asp:Label>
                        <br />
                        <asp:Label ID="CardCarrinhosQtd" runat="server"></asp:Label>
                    </div>
                    <div class="card-footer text-right">
                        <asp:ImageButton ID="DownloadCarrinho" runat="server" ImageUrl="~/Content/images/download.svg" AlternateText="Download" OnClick="DownloadCarrinho_Click" CssClass="ts-modal-espera-click" />
                    </div>
                </div>
            </div>--%>

        </div>

    </div>

    <div class="fixed-bottom mb-1 mr-2">
        <asp:Label ID="Versao" runat="server" CssClass="small text-muted font-italic float-right"></asp:Label>
    </div>

    <iframe id="iFrameDownload" runat="server" style="visibility: hidden; width: 0; height: 0;"></iframe>

</asp:Content>
