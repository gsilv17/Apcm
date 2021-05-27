using System.Collections.Generic;
using System.Data;
using System.Linq;
using Apcm.Service.Data;

namespace Apcm.Service.EstruturaMercadologica
{
    internal class EstruturaMercadologicaRepository : DataRepository
    {
        public EstruturaMercadologicaRepository(DataContext dbContext) : base(dbContext) { }

        public DataTable ObterEstruturaSams()
        {
            return DataContext.Load(EstruturaMercadologicaScripts.ObterEstruturaSams);
        }
        
        public Dictionary<int, string> ObterSecoes(string codSistema)
        {
            return DataContext.Load(
                EstruturaMercadologicaScripts.ObterSecoes, 
                DataParam.Create("CodSistema", codSistema)).ToDictionary<int, string>();
        }

        public Dictionary<int, string> ObterLinhas(string codSistema, int secao)
        {
            return DataContext.Load(
                EstruturaMercadologicaScripts.ObterLinhas,
                DataParam.Create("CodSistema", codSistema),
                DataParam.Create("Secao", secao)
                ).ToDictionary<int, string>();
        }

        public Dictionary<int, string> ObterSublinhas(string codSistema, int secao, int linha)
        {
            return DataContext.Load(
                EstruturaMercadologicaScripts.ObterSublinhas,
                DataParam.Create("CodSistema", codSistema),
                DataParam.Create("Secao", secao),
                DataParam.Create("Linha", linha)
                ).ToDictionary<int, string>();
        }

        public DataTable ObterEstruturaSad(string codSistema)
        {
            return DataContext.Load(
                EstruturaMercadologicaScripts.ObterEstruturaSad,
                DataParam.Create("CodSistema", codSistema));
        }
    }
}
