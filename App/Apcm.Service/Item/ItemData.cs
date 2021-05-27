using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace Apcm.Service.Item
{
    public class ItemData
    {
        public int idCarrinho { get; set; }
        public bool selecionado { get; set; }
        public bool enviado { get; set; }
        public bool podeSelecionar { get; set; }
        public int idLoad { get; set; }
        public int item_nbr { get; set; }
        public string login { get; set; }
        public string nome { get; set; }
        public DateTime? dhSelecionado { get; set; }
        public int cod_categoria { get; set; }
        public int cod_subcategoria { get; set; }
        public int cod_fineline { get; set; }
        public string item1_desc { get; set; }
    }

    [Serializable]
    public class PesquisaPrateleiraFiltro
    {
        public List<long> Itens { get; set; }
        public List<long> Fornecedores { get; set; }
        public List<PesquisaPrateleiraFiltroEstrutura> Estrutura { get; set; }
        public int PossuiCross { get; set; }
        public int EmEdicao { get; set; }
    }

    public class PesquisaPrateleiraFiltroEstrutura
    {
        public int CodCategoria { get; set; }
        public int CodSubcategoria { get; set; }
        public int CodFineline { get; set; }
    }

    public class PesquisaPrateleiraResultado
    {
        public int IdLoad { get; set; }
        public int item_nbr { get; set; }
        public string item1_desc { get; set; }
        public long upc_nbr { get; set; }
        public int vendor_nbr { get; set; }
        public int codCategoria { get; set; }
        public string DescrCategoria { get; set; }
        public int codSubcategoria { get; set; }
        public string DescrSubcategoria { get; set; }
        public int codFineline { get; set; }
        public string DescrFineline { get; set; }
        public bool EmEdicao { get; set; }
        public string Login { get; set; }
        public string Nome { get; set; }
        public bool PodeSelecionar { get { return !EmEdicao; } }
        public bool Selecionado { get; set; }
    }
}
