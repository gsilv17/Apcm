using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Web.Script.Serialization;

namespace Apcm.RetornoSad.Businness
{
    internal class ConsultaRetornoFEP
    {
        public RetornoConsultaLote ConsultaLote(string loteNbr)
        {
            string url = ConfigurationManager.AppSettings["endConsultaLote"].ToString();
            url = string.Format(url, loteNbr);
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
            try
            {
                WebResponse response = request.GetResponse();
                string responseResult = "";
                using (Stream responseStream = response.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(responseStream, System.Text.Encoding.UTF8);
                    responseResult = reader.ReadToEnd();
                }
                RetornoConsultaLote result = jsSerializer.Deserialize<RetornoConsultaLote>(responseResult);
                return result;
            }
            catch (WebException ex)
            {
                WebResponse errorResponse = ex.Response;
                using (Stream responseStream = errorResponse.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(responseStream, System.Text.Encoding.GetEncoding("utf-8"));
                    String errorText = reader.ReadToEnd();
                    // log errorText
                }
                throw;
            }
        }

        public RetornoConsultaDetalheLote ConsultaLoteDetalhe(string loteNbr)
        {
            string url = ConfigurationManager.AppSettings["endCosultaDetalheLote"].ToString();
            url = string.Format(url, loteNbr);
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
            try
            {
                WebResponse response = request.GetResponse();
                string responseResult = "";
                using (Stream responseStream = response.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(responseStream, System.Text.Encoding.UTF8);
                    responseResult = reader.ReadToEnd();
                }
                RetornoConsultaDetalheLote result = jsSerializer.Deserialize<RetornoConsultaDetalheLote>(responseResult);
                return result;
            }
            catch (WebException ex)
            {
                WebResponse errorResponse = ex.Response;
                using (Stream responseStream = errorResponse.GetResponseStream())
                {
                    StreamReader reader = new StreamReader(responseStream, System.Text.Encoding.GetEncoding("utf-8"));
                    String errorText = reader.ReadToEnd();
                    // log errorText
                }
                throw;
            }
        }
    }
}
