using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Apcm.Service.Data;

namespace Apcm.Service.Mapa
{
    internal sealed class MapaService: DataService<MapaRepository>, IMapaService
    { 
        public MapaService() : base() { }

        public MapaService(DataContext dbContext) : base(dbContext) { }

        public List<MapaData> MapaCarrinhoItem()
        {
            return Repository.MapaCarrinhoItem().ToObject<MapaData>();
        }

        public List<MapaData> MapaTemplate()
        {
            return Repository.MapaTemplate().ToObject<MapaData>();
        }

        public List<MapaData> MapaJSon()
        {
            return Repository.MapaJSon().ToObject<MapaData>();
        }
    }
}
