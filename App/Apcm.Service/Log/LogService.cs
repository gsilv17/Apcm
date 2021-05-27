using Apcm.Service.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Log
{
    internal sealed class LogService : DataService<LogRepository>, ILogService
    {
        public LogService() : base() { }

        public LogService(DataContext dbContext) : base(dbContext) { }

        public void Info(string emissor, string mensagem, params object[] argumentos)
        {
            Repository.RegistrarLog(emissor, "Info", string.Format(mensagem, argumentos));
        }

        public void Alerta(string emissor, string mensagem, params object[] argumentos)
        {
            Repository.RegistrarLog(emissor, "Alerta", string.Format(mensagem, argumentos));
        }

        public void Fixo(string emissor, string mensagem, params object[] argumentos)
        {
            Repository.RegistrarLogFixo(emissor, "Fixo", string.Format(mensagem, argumentos));
        }

        public void Fixo(string emissor, Exception ex, string mensagem, params object[] argumentos)
        {
            string msg = string.Format(mensagem, argumentos);
            msg = AddExceptionMsg(msg, ex);
            Repository.RegistrarLogFixo(emissor, "Fixo", msg);
        }

        public void Fixo(string emissor, Exception ex)
        {
            string msg = "Erro";
            msg = AddExceptionMsg(msg, ex);
            Repository.RegistrarLogFixo(emissor, "Fixo", msg);
        }

        public void Erro(string emissor, string mensagem, params object[] argumentos)
        {
            Repository.RegistrarLog(emissor, "Erro", string.Format(mensagem, argumentos));
        }

        public void Erro(string emissor, Exception ex, string mensagem, params object[] argumentos)
        {
            string msg = string.Format(mensagem, argumentos);
            msg = AddExceptionMsg(msg, ex);
            Repository.RegistrarLog(emissor, "Erro", msg);
        }

        public void Erro(string emissor, Exception ex)
        {
            string msg = "Erro";
            msg = AddExceptionMsg(msg, ex);
            Repository.RegistrarLog(emissor, "Erro", msg);
        }

        private string AddExceptionMsg(string msg, Exception ex)
        {
            msg = $"{msg} : {ex.Message}";

            if (ex.InnerException != null)
            {
                msg = AddExceptionMsg(msg, ex.InnerException);
            }

            return msg;
        }
    }
}
