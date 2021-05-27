using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Apcm.Service.Data;
using ClosedXML.Excel;
using System.Data;

namespace Apcm.Service.RetornoSAD
{
    internal sealed class ResultSearchService : DataService<ResultSearchRepository>, IResultSearch
    {
        public ResultSearchService() : base() { }

        public ResultSearchService(DataContext dataContext) : base(dataContext) { }
        public List<ResultSearchData> Pesquisar(string login, string lote, string msgRetorno, string statusLote)
        {
            return Repository.Pesquisar(login, lote, msgRetorno, statusLote);
        }

        public FileInfo ExportarDados(string login, string lote, string filesPath, string msgRetorno, string statusLote)
        {
            string identificacao = login;
            if (string.IsNullOrWhiteSpace(identificacao))
                identificacao = lote;
            
            string outputName = string.Format("TransicaoSams_RetornoItensenviados_{0}_{1:ddMMyy}_{1:HHmmss}.xlsx", identificacao, DateTime.Now);
            FileInfo outputFile = new FileInfo(Path.Combine(filesPath, outputName));


            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.AddWorksheet(Repository.ObterRetornoStatusItemError(login, lote, msgRetorno, statusLote), "Falha");
                wb.AddWorksheet(Repository.ObterRetornoStatusItemSuccess(login, lote, msgRetorno, statusLote), "Sucesso");
                wb.SaveAs(outputFile.FullName);
            }

            Action<FileInfo> deleteFile = async (fileInfo) =>
            {
                await Task.Delay(TimeSpan.FromMinutes(5));
                try
                {
                    if (fileInfo.Exists)
                    {
                        fileInfo.Delete();
                    }
                }
                catch { }
            };

            Task.Run(() => deleteFile(outputFile));
            return outputFile;
        }

        public DataTable PesquisarFiltroStatusRetorno()
        {
            return Repository.ObterFiltroStatusRetorno();
        }
    }
}
