using Apcm.Service.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Log
{
    internal sealed class LogRepository : DataRepository
    {
        public LogRepository(DataContext dbContext) : base(dbContext) { }

        public void RegistrarLog(string emissor, string tipo, string mensagem)
        {
            DataContext.ExecuteNonQuery(
                LogScripts.RegistrarLog, 
                DataParam.Create("Emissor", emissor), 
                DataParam.Create("Tipo", tipo), 
                DataParam.Create("Mensagem", mensagem));
        }

        public void RegistrarLogFixo(string emissor, string tipo, string mensagem)
        {
            int rCount = DataContext.ExecuteNonQuery(
                LogScripts.RegistrarLogFixo,
                DataParam.Create("Emissor", emissor),
                DataParam.Create("Mensagem", mensagem));

            if (rCount < 1)
            {
                RegistrarLog(emissor, tipo, mensagem);
            }
        }
    }
}
