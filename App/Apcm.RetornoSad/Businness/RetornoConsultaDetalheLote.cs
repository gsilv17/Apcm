using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.RetornoSad.Businness
{
    internal class RetornoConsultaDetalheLote
    {
        public string numeroLote { get; set; }
        public string mensagemRetorno { get; set; }
        public MensagemDetalhe[] mensagem { get; set; }
    }
}
