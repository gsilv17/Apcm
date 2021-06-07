using System.Collections.Generic;
using System.IO;
using System.Web.UI.WebControls;
using Apcm.Service.Item;
using Apcm.Service.Sad;
using Apcm.Service.AppUser;
using System;

namespace Apcm.Service.Carrinho
{
    public interface ICarrinhoService
    {
        [Obsolete("Fluxo Sams removido")]
        int CriarCarrinhoSams(List<PesquisaPrateleiraResultado> itens, string login, bool somenteGrid, string codSistema);

        int CriarCarrinhoSad(List<ProdutoData> produtos, AppUserData user, bool somenteGrid, string codSistema);

        int CriarCarrinhoDessinc(CarrinhoDessincSadInclusao parametros, string loginSad);

        /// <summary>
        /// Obtem uma relação de itens em edição.
        /// </summary>
        /// <param name="idCarrinho">Id do carrinho disponível.</param>
        /// <returns>Relação de itens em edição.</returns>
        List<CarrinhoItemData> ItensCarrinhoDisponivel(int idCarrinho);

        /// <summary>
        /// Registra a exportação do carrinho e cria o arquivo de exportação.
        /// Exporta somente itens em edição.
        /// </summary>
        /// <param name="idCarrinho">Identificação do carrinho.</param>
        /// <param name="filePath">Local para armazenamento do arquivo.</param>
        /// <returns>Informações do arquivo para envio ao cliente.</returns>
        FileInfo Exportar(int idCarrinho, string filePath);

        /// <summary>
        /// Cria o arquivo de exportação vazio.
        /// </summary>
        /// <param name="filePath">Local para armazenamento do arquivo.</param>
        /// <returns>Arquivo vazio para envio ao cliente.</returns>
        FileInfo Exportar(string filePath);

        ImportResult Importar(Stream inputFile, int idCarrinho, string login, string filePath, string codSistema);

        ImportResult Importar(Stream inputFile, string login, string filePath, string codSistema);

        string Enviar(int idCarrinho);
                     
        /// <summary>
        /// Para uso em DropDownList.
        /// Retorna a relação de carrinhos disponíveis para o usuário informado.
        /// </summary>
        /// <param name="login">Login de rede do usuário.</param>
        /// <param name="codOrigem">Orígem da chamada, Sams ou Sad.</param>
        /// <param name="codSistema">Sistema do carrinho.</param>
        /// <returns>Dicionario com carrinhos disponíveis. #[IdCarrinho] - dd/MM/aa - [Contagem de Itens em edição] Item(ns) Pendente(s).</returns>
        IDictionary<int, string> CarrinhosDisponiveis(string login, string codOrigem, string codSistema);

        /// <summary>
        /// Atualiza a estrutura mercadológica sams de acordo com a sessão, linha e sublinha atual.
        /// Obs.: Remode as descrições e departamento quando a estrutura não for localizada.
        /// </summary>
        /// <param name="idCarrinho">Identificação do carrinho para atualização.</param>
        void AtualizarDescrEstrutura(int idCarrinho);

        /// <summary>
        /// Marca os itens do carrinho apresentados com EmEdicao = false;
        /// </summary>
        /// <param name="idsCarrinhoItem">Identificação dos itens do carrinhos para alteração</param>
        /// <param name="login">Usuário responsável pela remoção.</param>
        void RemoverCarrinhoItens(List<int> idsCarrinhoItem, string login);

        /// <summary>
        /// Marca o item do carrinho com EmEdicao = false;
        /// </summary>
        /// <param name="idCarrinhoItem">Identificação do iten do carrinho para alteração</param>
        /// <param name="login">Usuário responsável pela remoção.</param>
        void RemoverCarrinhoItem(int idCarrinhoItem, string login);

        /// <summary>
        /// Obtém as contagens para apresentação nos cards da home.
        /// </summary>
        /// <returns>Contagens</returns>
        ContagemCardHome ObterContagemCardHome();

        /// <summary>
        /// Download do card sem Cross.
        /// </summary>
        /// <param name="filePath">Caminho de exportação.</param>
        /// <returns>Informações do arquivo para downoad</returns>
        FileInfo DownloadCardCross(string filePath);

        /// <summary>
        /// Download do card com Cross.
        /// </summary>
        /// <param name="filePath">Caminho de exportação.</param>
        /// <returns>Informações do arquivo para downoad</returns>
        FileInfo DownloadCardComCross(string filePath);

        /// <summary>
        /// Download do card Erro Retorno SAD.
        /// </summary>
        /// <param name="filePath">Caminho de exportação.</param>
        /// <returns>Informações do arquivo para downoad</returns>
        FileInfo DownloadCardErroRetorno(string filePath);

        /// <summary>
        /// Download do card Gestão de Carrinhos.
        /// </summary>
        /// <param name="filePath">Caminho de exportação.</param>
        /// <returns>Informações do arquivo para downoad</returns>
        FileInfo DownloadCardCarrinho(string filePath);

        /// <summary>
        /// Pesquisa de itens para Gestão de Carrinhos.
        /// </summary>
        /// <param name="filtro">Filtros de pesquisa.</param>
        /// <returns>Itens localizados.</returns>
        List<GestaoCarrinhoItens> PesquisaGestaoCarrinho(GestaoCarrinhoFiltro filtro);

        /// <summary>
        /// Localiza produtos diretamento no SAD.
        /// </summary>
        /// <param name="itens">Relação de produtos e/ou upcs</param>
        /// <param name="secao">Seção da estrutura mercadológica.</param>
        /// <param name="linha">Linha da estrutura mercadológica.</param>
        /// <param name="sublinha">Sublinha da estrutura mercadológica.</param>
        /// <param name="codSistema">Sistema de pesquisa.</param>
        /// <returns>Relação de produtos localizados.</returns>
        List<ProdutoData> PesquisarProdutos(List<long> itens, int secao, int linha, int sublinha, string codSistema);

        /// <summary>
        /// Obtém os dados do carrinho.
        /// </summary>
        /// <param name="idCarrinho">Identificação do carrinho</param>
        /// <returns>Dados do carrinho.</returns>
        CarrinhoData ObterCarrinho(int idCarrinho);

        /// <summary>
        /// Marca os itens do carrinho com EmEdicao = false com base na data de criação do carrinho.
        /// </summary>
        /// <param name="diasLimiteCarrinho">Dias limite para a data de criação (DhCriação <= Data Atual - X dias).</param>
        void RemoverCarrinhoItemAutomatico(int diasLimiteCarrinho);
    }
}
