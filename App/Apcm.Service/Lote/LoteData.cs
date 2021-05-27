using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Lote
{
    public class LoteData
    {
        public int IdLote { get; set; }
        public int IdCarrinho { get; set; }
       public DateTime DhEnvio { get; set; }
        public string NumeroLote { get; set; }
        public DateTime? DhRetorno { get; set; }
        public string StatusRetorno { get; set; }

        public string CodSistema { get; set; }
        public bool Dessinc { get; set; }
    }

    [Serializable]
    public class FiltroConsultaLote
    {
        public string Usuario { get; set; }
        public string NumeroLote { get; set; }
        public int Historico { get; set; }
        public string CodOrigem { get; set; }
        public DateTime? DataDe { get; set; }
        public DateTime? DataAte { get; set; }
        public int StatusLote { get; set; }
        public string StatusItem { get; set; }
        public string StatusItemExport { get; set; }
    }
    
    public class RetornoPesquisaLote
    {
        public string IdCarrinho { get; set; }
        public string TipoCarrinho { get; set; }
        public string NumeroLote { get; set; }
        public string Login { get; set; }
        public string Nome { get; set; }
        public string item_nbr { get; set; }
        public string produto_nbr { get; set; }
        public string StatusLote { get; set; }
        public string StatusItem { get; set; }
        public string DhEnvio { get; set; }
    }
}
