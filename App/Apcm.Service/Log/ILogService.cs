using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Log
{
    public interface ILogService
    {
        void Info(string emissor, string mensagem, params object[] argumentos);
        void Alerta(string emissor, string mensagem, params object[] argumentos);
        void Fixo(string emissor, string mensagem, params object[] argumentos);
        void Fixo(string emissor, Exception ex, string mensagem, params object[] argumentos);
        void Fixo(string emissor, Exception ex);
        void Erro(string emissor, string mensagem, params object[] argumentos);
        void Erro(string emissor, Exception ex, string mensagem, params object[] argumentos);
        void Erro(string emissor, Exception ex);
    }
}
