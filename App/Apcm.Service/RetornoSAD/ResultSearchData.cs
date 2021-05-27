using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.RetornoSAD
{
    [Serializable]
    public class ResultSearchData
    {
        public string Usuario { get; set; }
        public string StatusRetorno { get; set; }
        public string StatusRetornoLote { get; set; }
        public int CodProdutoSAD { get; set; }
        public string DescricaoItem { get; set; }
        public string CodVendor { get; set; }
        public string DescVendor { get; set; }
        public int CodigoCategoria { get; set; }
        public string DescCategoria { get; set; }
        public int CodigoSubCategoria { get; set; }
        public string DescSubCategoria { get; set; }
        public string Lote { get; set; }
        public int CodItemLink { get; set; }
        public string DiaHoraSelecionado { get; set; }
        public int CodFineLine { get; set; }
        public string Upc { get; set; }
        public string SigningDesc { get; set; }
        public int VnpkQty { get; set; }
        public string CaseUpc { get; set; }
        public int MdseOrignCode { get; set; }
        public string MdseClasfCode { get; set; }   
        public string VendorStockId { get; set; }
        public decimal VnpkCosAmt { get; set; }
        public decimal ItemLengthQty { get; set; }
        public decimal ItemWidthQty { get; set; }
        public decimal ItemHeightQty { get; set; }
        public int MiRrcvngDaysQty { get; set; }
        public int IpiTaxClassCd { get; set; }
        public string DataEnvio { get; set; }
    }
}
