using Apcm.Api.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Principal;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace Apcm.Api
{
    public class Auth : AuthorizationFilterAttribute
    {
        public override void OnAuthorization(HttpActionContext actionContext)
        {
            try
            {
                if (actionContext.Request.Headers.Authorization == null)
                {
                    throw new Exception("Este acesso requer autorização!");
                }

                string authToken64 = actionContext.Request.Headers.Authorization.Parameter;
                string authToken = Encoding.UTF8.GetString(Convert.FromBase64String(authToken64));
                List<string> authParams = authToken.Split(':').ToList();

                string username = authParams.First();
                string password = authParams.Last();

                if (username == "sad" && password == "apcmapi")
                {
                    GenericIdentity identity = new GenericIdentity(username);
                    IPrincipal principal = new GenericPrincipal(identity, null);
                    Thread.CurrentPrincipal = principal;
                    if (HttpContext.Current != null)
                    {
                        HttpContext.Current.User = principal;
                    }
                }
                else
                {
                    throw new Exception("Os dados de autorização informados são inválidos!");
                }
            }
            catch (Exception ex)
            {
                AuthError authError = new AuthError(ex);
                actionContext.Response = actionContext.Request.CreateResponse(HttpStatusCode.Unauthorized, authError);
            }

            base.OnAuthorization(actionContext);
        }
    }
}