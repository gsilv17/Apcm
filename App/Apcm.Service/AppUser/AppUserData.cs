using System;
using System.Collections.Generic;
using System.DirectoryServices.AccountManagement;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.Service.AppUser
{
    [Serializable]
    public class AppUserData
    {
        public string Dominio { get; private set; }
        public string Login { get; set; }
        public string LoginSad { get; set; }
        public string Nome { get; private set; }
        public string Email { get; private set; }
        public bool Admin { get; set; }
        public bool Editor { get; set; }
        public bool Atacado { get; set; }
        public bool Varejo { get; set; }
        public bool Ativo { get; private set; }
        


        private string DomainServer { get; set; }

        public AppUserData()
        {
            Ativo = false;
        }

        public AppUserData(IPrincipal principal, string domainServer)
        {
            DomainServer = domainServer;
            ObterLogin(principal);
            ObterNome();
        }

        private void ObterLogin(IPrincipal principal)
        {
            Login = string.Empty;
            Admin = false;
            Editor = false;
            Atacado = false;
            Varejo = false;
            Ativo = false;

            if (!principal.Identity.IsAuthenticated)
            {
                return;
            }

            List<string> blocks = principal.Identity.Name.Split('\\').ToList();
            if (blocks.Count() == 1)
            {
                blocks.Clear();
                blocks.Add("br");
                blocks.Add(principal.Identity.Name);
            }
            
            Dominio = blocks[0];
            Login = blocks[1];
            //DomainServer = string.Concat(Dominio, ".", DomainServer).Replace("..", ".");
        }

        private void ObterNome()
        {
            if (string.IsNullOrEmpty(Login))
            {
                return;
            }

            using (PrincipalContext context = new PrincipalContext(ContextType.Domain, DomainServer))
            {
                using (UserPrincipal userPrincipal = UserPrincipal.FindByIdentity(context, Login))
                {
                    if (userPrincipal != null)
                    {
                        Ativo = userPrincipal.Enabled ?? false;
                        Login = userPrincipal.SamAccountName.ToLower();
                        Nome = userPrincipal.Name;
                        Email = userPrincipal.EmailAddress;
                        
                    }
                }
            }
        }
    }
}
