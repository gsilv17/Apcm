using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Cross
{
    /// <summary>
    /// XREF_BR_IF_ITEM
    /// </summary>
    public class CrossData
    {
        /// <summary>
        /// XREF_BR_IF_ITEM_ID
        /// </summary>
        public int IdCross { get; set; }

        /// <summary>
        /// SAMS_ITEM_ID
        /// </summary>
        public int ItemNbr { get; set; }

        /// <summary>
        /// SAD_CODPRODU
        /// </summary>
        public string ProdutoNbr { get; set; }

        /// <summary>
        /// IDCARRINHOITEM
        /// </summary>
        public int IdCarrinhoItem { get; set; }

        public string ProdutoDesc { get; set; }

        public string Nome { get; set; }

        public bool EmEdicao { get; set; }

        public bool Selecionado { get; set; }
    }

    public class DessincLocalData
    {
        public string Login { get; set; }
        public List<int> Crosses { get; set; }
    }

    public class DessincPesquisaData
    {
        public string ProdutoNbr { get; set; }
        public string ItemNbr { get; set; }
        public string TipoDessinc { get; set; }
        public string Nome { get; set; }
        public DateTime Data { get; set; }
    }

    public class DessincSadReportEnvioData
    {
        public string idOrigem { get; set; }
        public List<DessincSadReportEnvioMensagemData> mensagem { get; set; }

    }

    public class DessincSadReportEnvioMensagemData
    {
        public string idLote { get; set; }
        public string idRegistro { get; set; }
    }

    public class DessincSadReportData
    {
        public int IdDessincSadReport { get; set; }
        public string NumeroLote { get; set; }
        public int IdCarrinhoItem { get; set; }
    }
    public class DessincSadReportLoteData
    {
        public List<int> Ids { get; set; }
        public string NumeroLote { get; set; }
    }
}
