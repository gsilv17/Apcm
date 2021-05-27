using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.EstruturaMercadologica
{
    public class EstruturaMercadologicaSadData
    {
        public int Secao { get; set; }
        public string SecaoDesc { get; set; }
        public int Linha { get; set; }
        public string LinhaDesc { get; set; }
        public int Sublinha { get; set; }
        public string SubinhaDesc { get; set; }
    }

    public class EstruturaMercadologicaSamsData
    {
        public int CodCategoria { get; set; }
        public string DescrCategoria { get; set; }
        public int? CodSubcategoria { get; set; }
        public string DescrSubcategoria { get; set; }
        public int? CodFineline { get; set; }
        public string DescrFineline { get; set; }

        public bool Selecionado { get; set; }
    }
}
