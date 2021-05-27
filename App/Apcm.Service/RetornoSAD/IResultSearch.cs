using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.RetornoSAD
{
    public interface IResultSearch
    {
        List<ResultSearchData> Pesquisar(string login, string lote, string msgRetorno, string statusLote);

        FileInfo ExportarDados(string login, string lote, string filesPath, string msgRetorno, string statusLote);

        DataTable PesquisarFiltroStatusRetorno();

    }
}
