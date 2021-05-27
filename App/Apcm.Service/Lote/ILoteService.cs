using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Lote
{
    public interface ILoteService
    {
        /// <summary>
        /// Inclui um lote se inexistente.
        /// </summary>
        /// <param name="idCarrinho">Carrinho do lote.</param>
        /// <param name="numeroLote">Lote obtido junto ao SAD.</param>
        /// <returns>Indicador de lote incluído.</returns>
        bool Incluir(int idCarrinho, string numeroLote);

        /// <summary>
        /// Obtém o último lote de um determinado carrinho.
        /// </summary>
        /// <param name="idCarrinho">Identificação do carrinho</param>
        /// <returns>Informações do lote.</returns>
        LoteData UltimoLote(int idCarrinho);
        
        /// <summary>
        /// Realiza o processamento de lotes.
        /// </summary>
        void ProcessarLotes();

        /// <summary>
        /// Relação distinta de códigos de retorno com erro ativos.
        /// </summary>
        /// <param name="codOrigem">Manutenção massiva</param>
        /// <param name="dataDe">Data Inicial</param>
        /// <param name="dataAte">Data Final</param>
        /// <returns>Dicionário para uso em dropdownlist específico.</returns>
        Dictionary<string, string> ObterStatusItem(string codOrigem, DateTime? dataDe, DateTime? dataAte);

        /// <summary>
        /// Obtém uma relação de lotes e seus respectivos itens.
        /// Limitado a 1.000 registros.
        /// </summary>
        /// <param name="filtroPesquisaLote">Filtro</param>
        /// <param name="qtdRegistros">Retorna a quantidade total de registros.</param>
        /// <returns>Relação de lotes.</returns>
        List<RetornoPesquisaLote> ConsultaLote(FiltroConsultaLote filtroPesquisaLote, out int qtdRegistros);

        /// <summary>
        /// Obtém uma relação de lotes e seus respectivos itens para exportação.
        /// </summary>
        /// <param name="filtroPesquisaLote">Filtro.</param>
        /// <param name="filePath">Local para exportação.</param>
        /// <returns>Relação de lotes para exportação.</returns>
        FileInfo ConsultaLoteExportacao(FiltroConsultaLote filtroPesquisaLote, string filePath);
    }
}
