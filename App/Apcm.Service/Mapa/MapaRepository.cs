using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Apcm.Service.Data;

namespace Apcm.Service.Mapa
{
    internal sealed class MapaRepository : DataRepository
    {
        public MapaRepository (DataContext dbContext) : base(dbContext) { }

        public DataTable MapaCarrinhoItem()
        {
            return DataContext.Load(MapaScripts.MapaCarrinhoItem);
        }

        public DataTable MapaTemplate()
        {
            return DataContext.Load(MapaScripts.MapaTemplate);
        }

        public DataTable MapaJSon()
        {
            return DataContext.Load(MapaScripts.MapaJSon);
        }
    }
}
