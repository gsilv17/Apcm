using Apcm.RetornoSad.ComandosBD;
using Apcm.RetornoSad.Consultas;
using Apcm.RetornoSad.Retornos;

namespace Apcm.RetornoSad.BD
{
    internal class ConsultaRetorno
    {
        public RetornoConsultaBD ConsultarLotesNaoProcessados(string strConn)
        {
            string consulta = ConsultasADO.ConsultarLotesNaoProcessados();
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarConsulta(strConn, consulta);
        }

        public RetornoGenerico InserirCarrinhoItemLote(string strConn, int idCarrinhoItem, int idLote, string codRetorno, string statusRetorno, int filial)
        {
            string consulta = ConsultasADO.InserirCarrinhoItemLote(idCarrinhoItem, idLote, codRetorno, statusRetorno, filial);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarNonQuery(strConn, consulta);
        }

        public RetornoGenerico AtualizarLote(string strConn, int idLote, string statusRetorno)
        {
            string consulta = ConsultasADO.AtualizarLote(idLote, statusRetorno);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarNonQuery(strConn, consulta);
        }

        public RetornoGenerico AtualizarCarrinhoItem(string strConn, int idCarrinhoItem)
        {
            string consulta = ConsultasADO.AtualizarCarrinhoItem(idCarrinhoItem);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarNonQuery(strConn, consulta);
        }

        public RetornoConsultaBD ObterDadosCarrinhoItem(string strConn, int idCarrinhoItem)
        {
            string consulta = ConsultasADO.ObterDadosCarrinhoItem(idCarrinhoItem);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarConsulta(strConn, consulta);
        }

        public RetornoConsultaBD InserirControle(string strConn, string process)
        {
            string consulta = ConsultasADO.InserirControle(process);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarConsulta(strConn, consulta);
        }

        public RetornoGenerico AtualizarControle(string strConn,  int idProcess, int totalLoteProcessado)
        {
            string consulta = ConsultasADO.AtualizarControle(idProcess, totalLoteProcessado);
            ComandosADO cmd = new ComandosADO();
            return cmd.ExecutarNonQuery(strConn, consulta);
        }
    }
}
