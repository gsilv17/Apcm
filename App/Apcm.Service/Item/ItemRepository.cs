using System.Collections.Generic;
using System.Data;
using Apcm.Service.Data;

namespace Apcm.Service.Item
{
    internal sealed class ItemRepository : DataRepository
    {
        public ItemRepository(DataContext dbContext) : base(dbContext) { }

        public DataTable PesquisaPrateleira(PesquisaPrateleiraFiltro filtro, out int qtdRegistros)
        {
            DataParam parameter = DataParam.Create("filtro", filtro.ToJSon());
            qtdRegistros = DataContext.ExecuteScalar<int>(ItemScripts.ContagemPesquisaPrateleira, parameter);
            return DataContext.Load(ItemScripts.PesquisaPrateleira, parameter);
        }
    }
}
