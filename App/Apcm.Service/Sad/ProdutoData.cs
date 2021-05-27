using Apcm.Service.AppUser;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Apcm.Service.Sad
{
    public class ProdutoData
    {
        public string CodProd { get; set; }
        public ProdutoBasicoData Basico { get; set; }
        public ProdutoEanData Ean { get; set; }
        public string ProdutoJSon { get; set; }
        public bool Selecionado { get; set; }

        public void DefinirProduto(object produto)
        {
            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
            if (produto is string)
            {
                produto = jsSerializer.Deserialize<object>(produto.ToString());
            }

            Dictionary<string, object> produtoDic = produto as Dictionary<string, object>;
            Dictionary<string, object> basicoDic = produtoDic["BASICO"] as Dictionary<string, object>;
            Dictionary<string, object> eanDic = produtoDic["EAN"] as Dictionary<string, object>;

            CodProd = produtoDic["CodProd"].ToString();
            Basico = new ProdutoBasicoData
            {
                Desc = basicoDic["Desc"].ToString(),
                Secao = basicoDic["Secao"].ToString(),
                Linha = basicoDic["Linha"].ToString(),
                Slinha = basicoDic["Slinha"].ToString()
            };
            Ean = new ProdutoEanData
            {
                Cean = eanDic["Cean"].ToString()
            };

            Selecionado = false;
            
            ProdutoJSon = jsSerializer.Serialize(produto);
        }
    }
    
    public class ProdutoBasicoData
    {
        public string Desc { get; set; }
        public string Secao { get; set; }
        public string Linha { get; set; }
        public string Slinha { get; set; }


        public string SecaoDesc { get; set; }
        public string LinhaDesc { get; set; }
        public string SlinhaDesc { get; set; }
    }

    public class ProdutoEanData
    {
        public string Cean { get; set; }
    }

    public class PesquisaProdutoData
    {
        public string idOrigem { get; set; }
        public List<PesquisaProdutoMensagemData> mensagem { get; set; }

        public PesquisaProdutoData(List<long> itens, int secao, int linha, int sublinha)
        {
            idOrigem = "BUSCAITENS";
            mensagem = new List<PesquisaProdutoMensagemData>();
            mensagem.Add(new PesquisaProdutoMensagemData());
            mensagem.First().codItem =
                itens.Count == 0 ?
                new List<string> { string.Empty } :
                itens.Select(i => i.ToString()).ToList();
            secao = secao <= 0 ? 0 : secao;
            linha = linha <= 0 ? 0 : linha;
            sublinha = sublinha <= 0 ? 0 : sublinha;
            mensagem.First().mercadologica = $"{secao.ToString("000")}{linha.ToString("00000")}{sublinha.ToString("00000")}";
        }
    }

    public class PesquisaProdutoMensagemData
    {
        public List<string> codItem { get; set; }
        public string mercadologica { get; set; }
    }

    public class IncluirDessincSadData
    {
        public string idOrigem { get; set; }

        public List<IncluirDessincSadMensagemData> mensagem { get; set; }

        public IncluirDessincSadData(List<string> produtos, string loginSad)
        {
            idOrigem = "DESINCITEM";
            IncluirDessincSadMensagemData msg = new IncluirDessincSadMensagemData();
            msg.matricula = loginSad;
            msg.codItem = produtos;
            mensagem = new List<IncluirDessincSadMensagemData> { msg };
        }
    }

    public class IncluirDessincSadMensagemData
    {
        public string matricula { get; set; }
        public List<string> codItem { get; set; }
    }
}
