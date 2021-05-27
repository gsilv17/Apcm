using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Mapa
{
    public interface IMapaService
    {
        /// <summary>
        /// Mapa para complemento de dados de Carrinho Item.
        /// </summary>
        /// <returns>Mapa de dados, bloco SQL.</returns>
        List<MapaData> MapaCarrinhoItem();

        /// <summary>
        /// Mapa para exportação e importação de template.
        /// </summary>
        /// <returns></returns>
        List<MapaData> MapaTemplate();

        /// <summary>
        /// Mapa para montagem do JSon de envio de dados.
        /// </summary>
        /// <returns></returns>
        List<MapaData> MapaJSon();
    }
}
