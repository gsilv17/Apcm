using Apcm.Service.Sad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Cross
{
    public interface ICrossService
    {
        void RegistrarCross(LoteDetalheMensagem loteDetalheMensagem);

        List<CrossData> Localizar(int produtoNbr, out bool log);

        bool DessincLocal(string login, List<CrossData> crosses);

        List<DessincPesquisaData> PesquisaDessinc(int? produtoNbr, int? itemNbr);

        void AtualizarDessincSadReport();

        void EnviarDessincSadReport();
    }
}
