using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Apcm.Service.Carrinho
{
    public class CarrinhoItemData
    {
        public int IdCarrinhoItem { get; set; }
        public int IdCarrinho { get; set; }
        public int? IdLoad { get; set; }
        public DateTime DhSelecionado { get; set; }
        public int? item_nbr { get; set; }
        public string produto_nbr { get; set; }
        public string item1_Desc { get; set; }

        public int? vendor_nbr { get; set; }
        public string DescrVendor { get; set; }

        public int? CodCategoria { get; set; }
        public int? CodSubcategoria { get; set; }
        public int? CodFineline { get; set; }
        public string DescrCategoria { get; set; }
        public string DescrSubcategoria { get; set; }
        public string DescrFineline { get; set; }
        
        public string ValidacaoTemplate { get; set; }
        
        public string Secao { get; set; }
        public string Linha { get; set;}
        public string Sublinha { get; set; }
        public string SecaoDesc { get; set; }
        public string LinhaDesc { get; set; }
        public string SublinhaDesc { get; set; }

        public bool Selecionado { get; set; }

        public string CodOrigem { get; set; }
        public bool OrigemSams { get { return CodOrigem != "Sad"; } }
        public bool OrigemSad { get { return CodOrigem == "Sad"; } }
    }

    public class GestaoCarrinhoFiltro
    {
        public List<long> Itens { get; set; }
        public List<long> Produtos { get; set; }
        public string Usuario { get; set; }

        /// <summary>
        /// Serializa os campos para o formato JSon.
        /// </summary>
        /// <returns>string JSon</returns>
        public string ToJSon()
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(this);
        }
    }

    public class GestaoCarrinhoItens
    {
        public int IdCarrinhoItem { get; set; }
        public int? item_nbr { get; set; }
        public string produto_nbr { get; set; }
        public string Descr { get; set; }
        public string Login { get; set; }
        public string LoginSad { get; set; }
        public string Nome { get; private set; }
        public string CodSistema { get; set; }
    }
}
