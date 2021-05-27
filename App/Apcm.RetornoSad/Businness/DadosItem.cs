using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.RetornoSad.Businness
{
    internal class DadosItem
    {
        public int CodProdutoSAD { get; set; }
        public string DescricaoItem { get; set; }
        public string CodVendor { get; set; }
        public string DescVendor { get; set; }
        public int CodigoCategoria { get; set; }
        public string DescCategoria { get; set; }
        public int CodigoSubCategoria { get; set; }
        public string DescSubCategoria { get; set; }
        public int CodItemOif { get; set; }
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
        public string Multipack { get; set; }
        public int DigitoUpcReal { get; set; }
        public int PackFornecedor { get; set; }
        public List<DadosItem> PreencherData(DataTable dt)
        {
            List<DadosItem> lista = new List<DadosItem>();
            if (dt == null)
                return lista;
            try
            {
                lista = (from DataRow item in dt.Rows
                         select new DadosItem
                         {
                             CodProdutoSAD = Int32.Parse(item["CodProdutoSAD"].ToString()),
                             DescricaoItem = item["DescricaoItem"].ToString(),
                             CodVendor = item["CodVendor"].ToString(),
                             DescVendor = item["DescVendor"].ToString(),
                             CodigoCategoria = Int32.Parse(item["CodigoCategoria"].ToString()),
                             DescCategoria = item["DescCategoria"].ToString(),
                             CodigoSubCategoria = Int32.Parse(item["CodigoSubCategoria"].ToString()),
                             DescSubCategoria = item["DescSubCategoria"].ToString(),
                             CodItemOif = Int32.Parse(item["CodItemOif"].ToString()),
                             DiaHoraSelecionado = item["DiaHoraSelecionado"].ToString(),
                             CodFineLine = Int32.Parse(item["CodFineLine"].ToString()),
                             Upc = item["Upc"].ToString(),
                             SigningDesc = item["SigningDesc"].ToString(),
                             VnpkQty = Int32.Parse(item["VnpkQty"].ToString()),
                             CaseUpc =item["CaseUpc"].ToString(),
                             MdseOrignCode = Int32.Parse(item["MdseOrignCode"].ToString()),
                             VendorStockId = item["VendorStockId"].ToString(),
                             VnpkCosAmt = Decimal.Parse(item["VnpkCosAmt"].ToString()),
                             ItemLengthQty = Decimal.Parse(item["ItemLengthQty"].ToString()),
                             ItemWidthQty = Decimal.Parse(item["ItemWidthQty"].ToString()),
                             ItemHeightQty = Decimal.Parse(item["ItemHeightQty"].ToString()),
                             MiRrcvngDaysQty = Int32.Parse(item["MiRrcvngDaysQty"].ToString()),
                             IpiTaxClassCd = Int32.Parse(item["IpiTaxClassCd"].ToString()),
                             Multipack = item["MultiPack"].ToString(),
                             DigitoUpcReal = Int32.Parse(item["DigitoUpcReal"].ToString()),
                             PackFornecedor = Int32.Parse(item["PackFornecedor"].ToString())
                         }).ToList();
                return lista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
