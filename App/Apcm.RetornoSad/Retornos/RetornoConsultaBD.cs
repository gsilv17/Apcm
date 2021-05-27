using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.RetornoSad.Retornos
{
    public class RetornoConsultaBD : RetornoGenerico
    {
        public DataTable RetornoDt { get; set; }
    }
}
