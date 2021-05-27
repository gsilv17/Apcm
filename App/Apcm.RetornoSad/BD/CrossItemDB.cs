using Apcm.RetornoSad.Businness;
using Apcm.RetornoSad.ComandosBD;
using Apcm.RetornoSad.Consultas;
using Apcm.RetornoSad.Retornos;

namespace Apcm.RetornoSad.BD
{
    internal class CrossItemDB
    {
        public RetornoConsultaBD ObterIdCrossItem(string strConn, int idCarrinhoitem)
        {
            string consulta = ConsultasADO.ObterIdCrossItem(idCarrinhoitem);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarConsulta(strConn, consulta);
        }

        public RetornoConsultaBD ObterIdCrossProduto(string strConn, int idCarrinhoitem)
        {
            string consulta = ConsultasADO.ObterIdCrossProduto(idCarrinhoitem);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarConsulta(strConn, consulta);
        }

        public RetornoGenerico InserirCrossItem(string strConn, CrossItem dados)
        {
            string consulta = ConsultasADO.InserirCrossItem(dados);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarNonQuery(strConn, consulta);
        }

        public RetornoConsultaBD ObterCrossItem(string strConn, int idCross)
        {
            string consulta = ConsultasADO.ObterCrossItem(idCross);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarConsulta(strConn, consulta);
        }

        public RetornoGenerico InserirCrossItemLog(string strConn, CrossItem dados, int idCross)
        {
            string consulta = ConsultasADO.InserirCrossItemLog(dados, idCross);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarNonQuery(strConn, consulta);
        }

        public RetornoGenerico AtualizarCrossItem(string strConn, CrossItem dados, int idCross, string eanSAD)
        {
            string consulta = ConsultasADO.AtualizarCrossItem(dados, idCross, eanSAD);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarNonQuery(strConn, consulta);
        }

        public RetornoGenerico AtualizarCrossProduto(string strConn, int idCarrinhoItem)
        {
            string consulta = ConsultasADO.AtualizarCrossProduto(idCarrinhoItem);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarNonQuery(strConn, consulta);
        }

        public RetornoConsultaBD ObterCodOrigem(string strConn, int idCarrinhoItem)
        {
            string consulta = ConsultasADO.ObterCodOrigem(idCarrinhoItem);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarConsulta(strConn, consulta);
        }
    }
}
