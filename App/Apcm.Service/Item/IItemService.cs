using System.Collections.Generic;

namespace Apcm.Service.Item
{
    public interface IItemService
    {
        /// <summary>
        /// Retorna itens disponíveis para o carrinho. 
        /// podem estar selecionados.
        /// Retorno dos primeiros 1.000 registros.
        /// </summary>
        /// <param name="filtro">Filtro de pesquisa.</param>
        /// <param name="qtdRegistros">Contagem total de registros.</param>
        /// <returns>Relação de itens.</returns>
        List<PesquisaPrateleiraResultado> PesquisaPrateleira(PesquisaPrateleiraFiltro filtro, out int qtdRegistros);
    }
}
