using System;
using System.Collections.Generic;
using Apcm.Service.Data;

namespace Apcm.Service.AppUser
{
    internal sealed class AppUserService : DataService<AppUserRepository>, IAppUserService
    {
        public AppUserService() : base() { }

        public AppUserService(DataContext dataContext) : base(dataContext) { }

        public void Verificar(AppUserData usuario)
        {
            Repository.Verificar(usuario);
        }

        public void ObterPerfil(AppUserData usuario)
        {
            Repository.ObterPerfil(usuario);
        }

        public List<AppUserData> Localizar(int modoVisualizacao, string filtro)
        {
            return Repository.Localizar(modoVisualizacao, filtro);
        }

        public bool Incluir(string loginRede, string loginSad, bool admin, bool editor, bool atacado, bool varejo)
        {
            return Repository.Incluir(loginRede, loginSad, admin, editor, atacado, varejo) == 1;
        }

        public void Atualizar(string login, bool admin, bool editor, bool atacado, bool varejo)
        {
            Repository.Atualizar(login, admin, editor, atacado, varejo);
        }

        public bool Atualizar(string login, string loginSad)
        {
            if(string.IsNullOrEmpty(loginSad))
            {
                return false;
            }

            return Repository.Atualizar(login, loginSad) == 1;
        }

        public void Excluir(string login)
        {
            Repository.Excluir(login);
        }

    }
}
