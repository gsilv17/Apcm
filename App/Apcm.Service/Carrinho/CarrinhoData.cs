using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Apcm.Service.Carrinho
{
    public class CarrinhoData
    {
        public int IdCarrinho { get; set; }
        public string Login { get; set; }
        public DateTime DhCriacao { get; set; }
        public string CodOrigem { get; set; }
        public bool OrigemSams { get { return CodOrigem != "Sad"; } }
        public bool OrigemSad { get { return CodOrigem == "Sad"; } }
    }

    public class ImportResult
    {
        public string AlertMsg { get; set; }
        public string AlertType { get; set; }
        public FileInfo OutputFile { get; set; }
        public bool PodeEnviar { get; set; }
        public int IdCarrinho { get; set; }
    }

    public class ContagemCardHome
    {
        //public int QtdSemDexPara { get; set; }
        //public int QtdComDexPara { get; set; }
        //public int QtdItens { get; set; }
        //public decimal PercentSemDexPara { get; set; }
        //public decimal PercentComDexPara { get; set; }
        public int QtdRetornoErroSad { get; set; }
        public int QtdRetornoSad { get; set; }
        public decimal PercentRetornoErroSad { get; set; }
        public int QtdCarrinhoItens { get; set; }
        public int QtdCarrinhoItensErro { get; set; }
        public decimal PercentCarrinhoItensErro { get; set; }
    }
    public class CarrinhoDessincSadInclusao
    {
        public List<string> Produtos { get; set; }
        public string Login { get; set; }
    }

    public class CarrinhoDessincRetorno
    {
        public string NumeroLote { get; set; }
        public List<CarrinhoDessincRetornoDetalhe> Produtos { get; set; }
    }

    public class CarrinhoDessincRetornoDetalhe
    {
        public string ProdutoNbr { get; set; }
        public string CodRetorno { get; set; }
        public string MsgRetorno { get; set; }
    }
}
