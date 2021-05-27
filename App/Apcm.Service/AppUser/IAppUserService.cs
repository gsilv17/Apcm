using System.Collections.Generic;

namespace Apcm.Service.AppUser
{
    public interface IAppUserService
    {
        void Verificar(AppUserData usuario);
        
        void ObterPerfil(AppUserData usuario);

        List<AppUserData> Localizar(int modoVisualizacao, string filtro);

        bool Incluir(string loginRede, string loginSad, bool admin, bool editor, bool atacado, bool varejo);

        void Atualizar(string login, bool admin, bool editor, bool atacado, bool varejo);

        bool Atualizar(string login, string loginSad);

        void Excluir(string login);
    }
}
