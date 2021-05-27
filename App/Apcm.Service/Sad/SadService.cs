using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;
using System.Linq;
using Apcm.Service.Data;
using Apcm.Service.Item;
using Apcm.Service.Lote;

namespace Apcm.Service.Sad
{
    public static class SadService
    {
        internal static string UrlBaseAtacado { get; private set; }
        internal static string UrlBaseVarejo { get; private set; }
        internal static string UrlIncluirSolicitacao { get; private set; }
        internal static string UrlBuscaProdutos { get; private set; }
        internal static string UrlBuscaProdutosLoteDetalhe { get; private set; }
        internal static string UrlConsultaLote { get; private set; }
        internal static string UrlConsultaDetalhe { get; private set; }
        internal static string UrlDessinc { get; private set; }
        internal static string UrlDessincSadReport { get; private set; }

        public static void DefinirUrlsConsulta(string baseUrlAtacado, string baseUrlVarejo, string consultaLote, string consultaDetalhe)
        {
            UrlBaseAtacado = baseUrlAtacado;
            UrlBaseVarejo = baseUrlVarejo;
            UrlConsultaLote = consultaLote;
            UrlConsultaDetalhe = consultaDetalhe;
        }

        public static void DefinirUrlsInclusao(string baseUrlAtacado, string baseUrlVarejo, string incluirSolicitacao, string buscaProdutos, string dessinc, string dessincSadReport)
        {
            UrlBaseAtacado = baseUrlAtacado;
            UrlBaseVarejo = baseUrlVarejo;
            UrlIncluirSolicitacao = incluirSolicitacao;
            UrlBuscaProdutos = buscaProdutos;
            UrlDessinc = dessinc;
            UrlDessincSadReport = dessincSadReport;
        }

        internal static string IncluirSolicitacao(string json, string codSistema)
        {
            return Inclusao(json, string.Concat(GetUrlBase(codSistema), UrlIncluirSolicitacao));
        }

        internal static string BuscaProdutos(string json, string codSistema)
        {
            return Inclusao(json, string.Concat(GetUrlBase(codSistema), UrlBuscaProdutos));
        }

        internal static string Dessinc(string json)
        {
            return Inclusao(json, string.Concat(GetUrlBase("Atacado"), UrlDessinc));
        }

        internal static string DessincSadReport(string json)
        {
            return Inclusao(json, string.Concat(GetUrlBase("Atacado"), UrlDessincSadReport));
        }

        internal static string GetUrlBase(string codSistema)
        {
            string urlBase = codSistema == "Atacado" ? UrlBaseAtacado : codSistema == "Varejo" ? UrlBaseVarejo : string.Empty;
            if (string.IsNullOrEmpty(urlBase))
            {
                throw new Exception("CodSistema indefinido para acesso ao SAD");
            }

            return urlBase;
        }

        internal static string Inclusao(string json, string url)
        {
            string sadResponse = GetSadResponse(WebRequestMethods.Http.Post, url, json);
            return GetNumeroLote(sadResponse);
        }

        private static string GetNumeroLote(string sadResponse)
        {
            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();

            try
            {
                object responseData = jsSerializer.Deserialize<object>(sadResponse);

                Dictionary<string, object> responseDic = responseData as Dictionary<string, object>;
                if (responseDic.ContainsKey("numeroLote"))
                {
                    return responseDic["numeroLote"].ToString();
                }
                else
                {
                    throw new Exception("Lote não localizado.");
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Não foi possível obter o número do lote.", ex);
            }
        }

        internal static bool BuscarProdutosLote(string lote, string codSistema)
        {
            string sadResponse = GetSadResponse(WebRequestMethods.Http.Get, string.Format(string.Concat(GetUrlBase(codSistema), UrlConsultaLote), lote), string.Empty);
            return GetLoteProcessado(sadResponse, lote);
        }

        internal static List<ProdutoData> BuscarProdutosLoteDetalhe(string lote, string codSistema)
        {
            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();

            try
            {
                string pesquisaJSon = GetSadResponse(WebRequestMethods.Http.Get, string.Format(string.Concat(GetUrlBase(codSistema), UrlConsultaDetalhe), lote), string.Empty);
                jsSerializer.MaxJsonLength = pesquisaJSon.Length;
                object pesquisaObj = jsSerializer.Deserialize<object>(pesquisaJSon);
                object[] mensagensObj = ((pesquisaObj as Dictionary<string, object>)["mensagem"]) as object[];

                if ((mensagensObj[0] as Dictionary<string, object>).ContainsKey("CodRet"))
                {
                    return new List<ProdutoData>();
                }

                List<ProdutoData> produtos = new List<ProdutoData>();
                foreach (object produtoObj in mensagensObj)
                {
                    ProdutoData produto = new ProdutoData();
                    produto.DefinirProduto(produtoObj);
                    produtos.Add(produto);
                }

                return produtos;
            }
            catch (Exception ex)
            {
                throw new Exception($"Não foi possível realizar a pesquisa de produtos no sistema {codSistema}!", ex);
            }
        }

        /// <summary>
        /// Verifica se um lote foi processado.
        /// </summary>
        /// <param name="lotePendente">Lote pendente.</param>
        /// <returns>Indicador de lote processado.</returns>
        internal static bool ConsultarLote(LoteData lotePendente)
        {
            string sadResponse = GetSadResponse(WebRequestMethods.Http.Get, string.Format(string.Concat(GetUrlBase(lotePendente.CodSistema), UrlConsultaLote), lotePendente.NumeroLote), string.Empty);
            return GetLoteProcessado(sadResponse, lotePendente.NumeroLote);
        }

        internal static LoteDetalhe ConsultarLoteDetalhe(LoteData lotePendente)
        {
            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();

            try
            {
                string loteDetalheJSon = GetSadResponse(WebRequestMethods.Http.Get, string.Format(string.Concat(GetUrlBase(lotePendente.CodSistema), UrlConsultaDetalhe), lotePendente.NumeroLote), string.Empty);
                return jsSerializer.Deserialize<LoteDetalhe>(loteDetalheJSon);
            }
            catch (Exception ex)
            {
                throw new Exception("Não foi possível realizar a pesquisa!", ex);
            }
        }



        private static bool GetLoteProcessado(string sadResponse, string lote)
        {
            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();

            try
            {
                object responseData = jsSerializer.Deserialize<object>(sadResponse);

                Dictionary<string, object> responseDic = responseData as Dictionary<string, object>;
                if (responseDic.ContainsKey("numeroLote"))
                {
                    if (responseDic["numeroLote"].ToString() != lote)
                    {
                        throw new Exception("O Lote retornado não confere com o lote pesquisado.");
                    }
                }
                else
                {
                    throw new Exception("Lote não localizado.");
                }

                if (responseDic.ContainsKey("mensagemRetorno"))
                {
                    return responseDic["mensagemRetorno"].ToString() == "Lote processado.";
                }
                else
                {
                    throw new Exception("Mensagem de retorno não localizada.");
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Não foi possível verificar a situação do lote.", ex);
            }
        }

        private static string GetSadResponse(string method, string url, string requestParam)
        {
            byte[] requestBytes = Encoding.ASCII.GetBytes(requestParam);
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = method; // WebRequestMethods.Http.Post;
            request.ContentType = "application/json";
            request.Timeout = (30 * 1000); // 30 segundos

            //request.ContentLength = requestBytes.Length;
            //request.UseDefaultCredentials = true;
            //request.Proxy = new WebProxy(SadUrl.WebProxy, true); // http://proxy.wal-mart.com:8080
            //request.Proxy.Credentials = CredentialCache.DefaultCredentials;

            if (!string.IsNullOrEmpty(requestParam))
            {
                using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
                {
                    writer.Write(requestParam);
                }
            }

            WebResponse response = request.GetResponse();
            string responseResult = string.Empty;
            using (StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
            {
                responseResult = reader.ReadToEnd();
            }

            return responseResult;
        }
    }


}
