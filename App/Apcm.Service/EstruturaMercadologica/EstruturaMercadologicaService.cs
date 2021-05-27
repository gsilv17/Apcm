using System.Collections.Generic;
using System.Linq;
using Apcm.Service.Data;

namespace Apcm.Service.EstruturaMercadologica
{
    internal sealed class EstruturaMercadologicaService : DataService<EstruturaMercadologicaRepository>, IEstruturaMercadologicaService
    {
        public EstruturaMercadologicaService() : base() { }
        public EstruturaMercadologicaService(DataContext DataContext) : base(DataContext) { }

        public List<EstruturaMercadologicaSamsData> ObterCategorias()
        {
            return Repository
                .ObterEstruturaSams()
                .ToObject<EstruturaMercadologicaSamsData>()
                .GroupBy(e => e.CodCategoria)
                .Select(g =>
                    new EstruturaMercadologicaSamsData
                    {
                        CodCategoria = g.First().CodCategoria,
                        DescrCategoria = g.First().DescrCategoria
                    })
                .OrderBy(o => o.CodCategoria)
                .ToList();
        }

        public List<EstruturaMercadologicaSamsData> ObterSubcategorias(List<EstruturaMercadologicaSamsData> estrutura)
        {
            return Repository
                .ObterEstruturaSams()
                .ToObject<EstruturaMercadologicaSamsData>()
                .Where(s => estrutura.Count == 0 || estrutura.Any(c => c.CodCategoria == s.CodCategoria))
                .GroupBy(s => new { s.CodCategoria, s.CodSubcategoria })
                .Select(g =>
                    new EstruturaMercadologicaSamsData
                    {
                        CodCategoria = g.First().CodCategoria,
                        DescrCategoria = g.First().DescrCategoria,
                        CodSubcategoria = g.First().CodSubcategoria,
                        DescrSubcategoria = g.First().DescrSubcategoria
                    })
                .OrderBy(o => o.CodCategoria)
                .ThenBy(o => o.CodSubcategoria)
                .ToList();
        }

        public List<EstruturaMercadologicaSamsData> ObterFinelines(List<EstruturaMercadologicaSamsData> estrutura)
        {
            return Repository
                .ObterEstruturaSams()
                .ToObject<EstruturaMercadologicaSamsData>()
                .Where(f => estrutura.Count == 0 || estrutura.Any(e => e.CodCategoria == f.CodCategoria && (!e.CodSubcategoria.HasValue || e.CodSubcategoria == f.CodSubcategoria)))
                .OrderBy(o => o.CodCategoria)
                .ThenBy(o => o.CodSubcategoria)
                .ThenBy(o => o.CodSubcategoria)
                .ToList();
        }

        public Dictionary<int, string> ObterSecoes(string codSistema)
        {
            return Repository.ObterSecoes(codSistema);
        }

        public Dictionary<int, string> ObterLinhas(string codSistema, int secao)
        {
            return Repository.ObterLinhas(codSistema, secao);
        }

        public Dictionary<int, string> ObterSublinhas(string codSistema, int secao, int linha)
        {
            return Repository.ObterSublinhas(codSistema, secao, linha);
        }

        public List<EstruturaMercadologicaSadData> ObterEstruturaSad(string codSistema)
        {
            return Repository.ObterEstruturaSad(codSistema).ToObject<EstruturaMercadologicaSadData>();
        }
    }
}
