using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using Apcm.Service.Data;

namespace Apcm.Service.Item
{
    internal sealed class ItemService : DataService<ItemRepository>, IItemService
    {
        public ItemService() : base() { }

        public ItemService(DataContext dbContext) : base(dbContext) { }

        public List<PesquisaPrateleiraResultado> PesquisaPrateleira(PesquisaPrateleiraFiltro filtro, out int qtdRegistros)
        {
            return Repository.PesquisaPrateleira(filtro, out qtdRegistros)
                .ToObject<PesquisaPrateleiraResultado>()
                .OrderBy(o => o.EmEdicao)
                .ThenBy(o => o.item_nbr)
                .ToList();
        }
        
        /// <summary>
        /// Itens previamente selecionados ainda não removidos ou enviados não pode ser selecionados.
        /// </summary>
        /// <param name="item">Item para definição.</param>
        private void DefinirPodeSelecionar(ItemData item)
        {
            item.podeSelecionar = !item.dhSelecionado.HasValue;
        }

        /// <summary>
        /// Reordena os itens pelo numero mantendo por último os itens que não podem ser selecionados.
        /// </summary>
        /// <param name="itens">Itens para ordenação.</param>
        /// <returns>Nova lista de itens reordenada.</returns>
        private List<ItemData> ReordenarItens(List<ItemData> itens)
        {
            return itens.OrderByDescending(o => o.podeSelecionar).ThenBy(o => o.item_nbr).ToList();
        }

    }
}
