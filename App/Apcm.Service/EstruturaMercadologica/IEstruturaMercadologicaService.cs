using System.Collections.Generic;

namespace Apcm.Service.EstruturaMercadologica
{
    public interface IEstruturaMercadologicaService
    {
        List<EstruturaMercadologicaSamsData> ObterCategorias();

        List<EstruturaMercadologicaSamsData> ObterSubcategorias(List<EstruturaMercadologicaSamsData> estrutura);

        List<EstruturaMercadologicaSamsData> ObterFinelines(List<EstruturaMercadologicaSamsData> estrutura);

        Dictionary<int, string> ObterSecoes(string codSistema);

        Dictionary<int, string> ObterLinhas(string codSistema, int secao);

        Dictionary<int, string> ObterSublinhas(string codSistema, int secao, int linha);

        List<EstruturaMercadologicaSadData> ObterEstruturaSad(string codSistema);
    }
}
