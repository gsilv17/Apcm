using Apcm.Service.AppUser;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Apcm.Service.Sad
{
    public class LoteDetalhe
    {
        public string numeroLote { get; set; }
        public string mensagemRetorno { get; set; }
        public LoteDetalheMensagem[] mensagem { get; set; }
        
    }

    public class LoteDetalheMensagem
    {
        public int idRegistro { get; set; }
        public string CodRet { get; set; }
        public int CodProd { get; set; }
        public int Tean { get; set; }
        public string Cean { get; set; }
        public int Eandg { get; set; }
        public string MsgRet { get; set; }
        public string Filpfl { get; set; }
    }

}
