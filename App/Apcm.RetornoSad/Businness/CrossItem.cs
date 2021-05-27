using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.RetornoSad.Businness
{
    internal class CrossItem
    {
        public int SamsItemId { get; set; }
        public string SamsUpcNbr { get; set; }
        public string SamsVendorNbr { get; set; }
        public int SamsPluNbr { get; set; }
        public int SadCodProdu { get; set; }
        public string SadCodigoEan { get; set; }
        public int IdCarrinhoItem { get; set; }
        public string ItemDesc { get; set; }
        public string StatusItem { get; set; }
        public int Qtdepack { get; set; }
        public string Multipack { get; set; }
        public string UpcReal { get; set; }
        public string DtAlteração { get; set; }
        public int DigitoUpcReal { get; set; }
        public int TipoEan { get; set; }
        public int EanDig { get; set; }

        public List<CrossItem> ConverterDados(DataTable dt)
        {
            List<CrossItem> listaRetorno = new List<CrossItem>();
            if (dt == null)
                return listaRetorno;

            if (dt.Rows.Count <= 0)
                return listaRetorno;

            try
            {
                listaRetorno = (from DataRow item in dt.Rows
                                select new CrossItem
                                {
                                    SamsItemId = Int32.Parse(item["SamsItemId"].ToString()),
                                    SamsUpcNbr = item["SamsUpcNbr"].ToString(),
                                    SamsVendorNbr = item["SamsVendorNbr"].ToString(),
                                    SamsPluNbr = Int32.Parse(item["SamsPluNbr"].ToString()),
                                    SadCodProdu = Int32.Parse(item["SadCodProdu"].ToString()),
                                    SadCodigoEan = item["SadCodigoEan"].ToString(),
                                    IdCarrinhoItem = Int32.Parse(item["IdCarrinhoItem"].ToString()),
                                    ItemDesc = item["ItemDesc"].ToString(),
                                    StatusItem = item["StatusItem"].ToString(),
                                    Qtdepack = Int32.Parse(item["Qtdepack"].ToString()),
                                    Multipack = item["Multipack"].ToString(),
                                    UpcReal = item["UpcReal"].ToString(),
                                    DtAlteração = item["DtAlteração"].ToString(),
                                    DigitoUpcReal = Int32.Parse(item["DigitoUpcReal"].ToString()),
                                    TipoEan = Int32.Parse(item["TipoEan"].ToString()),
                                    EanDig = Int32.Parse(item["EanDig"].ToString())
                                }).ToList();
            }
            catch (Exception)
            {
                return listaRetorno;
            }

            return listaRetorno;
        }
    }
}
