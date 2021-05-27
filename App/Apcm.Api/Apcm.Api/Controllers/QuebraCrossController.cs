using Apcm.Api.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace Apcm.Api.Controllers
{
    [EnableCors("*", "*", "*")]
    [Auth]
    public class QuebraCrossController : ApiController
    {
        public void Delete(Produto produtos)
        {

        }

    }
}
