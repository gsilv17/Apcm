using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.RetornoSad.Retornos
{
    public class RetornoGenerico
    {
        public bool Sucesso { get; set; }
        public string Mensagem { get; set; }
        public int Id { get; set; }
        public int TipoRetorno { get; set; }
        public string IdStr { get; set; }

        public string CodOrigem { get; set; }
    }
}
