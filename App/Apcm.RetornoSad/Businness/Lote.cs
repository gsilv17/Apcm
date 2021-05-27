using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace Apcm.RetornoSad.Businness
{
    internal class Lote
    {
        public int IdLote { get; set; }
        public string NumeroLote { get; set; }
        public int  IdCarrinho { get; set; }

        public List<Lote> ConverterLista(DataTable dt)
        {
            if (dt == null)
                return new List<Lote>();

            if (dt.Rows.Count == 0)
                return new List<Lote>();

            List<Lote> listaRetorno = new List<Lote>();
            try
            {
                listaRetorno = (from DataRow item in dt.Rows
                                select new Lote
                                {
                                    IdLote = Int32.Parse(item["IdLote"].ToString()),
                                    NumeroLote = item["NumeroLote"].ToString(),
                                    IdCarrinho = Int32.Parse(item["IdCarrinho"].ToString())
                                }).ToList();
            }
            catch
            {
                return listaRetorno;
            }

            return listaRetorno;
        }
    }
}
