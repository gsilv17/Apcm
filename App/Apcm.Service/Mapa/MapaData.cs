using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.Mapa
{
    public class MapaData
    {
        public int IdMapa { get; set; }
        public string EntidadeOrigem { get; set; }
        public string CampoOrigem { get; set; }
        public string CampoCarrinhoItem { get; set; }
        public string NomeColuna { get; set; }
        public int? Ordem { get; set; }
        public string Grupo { get; set; }
        public char Tipo { get; set; }
        public int? Tamanho { get; set; }
        public int? Precisao { get; set; }
        public bool Obrigatorio { get; set; }
        public bool PodeAlterar { get; set; }
        public string CampoJSon { get; set; }
        public string GrupoJSon { get; set; }
        public int? OrdemJSon { get; set; }
        public string Descricao { get; set; }
    }
}
