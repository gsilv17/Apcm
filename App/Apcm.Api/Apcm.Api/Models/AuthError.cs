using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Apcm.Api.Models
{
    public class AuthError
    {
        public string Message { get; set; }

        public AuthError(Exception ex)
        {
            Message = ex.Message;
        }
    }
}