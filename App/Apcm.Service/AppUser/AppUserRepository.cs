using System.Collections.Generic;
using System.Data;
using Apcm.Service.Data;

namespace Apcm.Service.AppUser
{
    internal class AppUserRepository : DataRepository
    {
        public AppUserRepository(DataContext dataContext) : base(dataContext) { }
        
        public void Verificar(AppUserData user)
        {
            DataTable tbl = DataContext.Load(
                AppUserScripts.Verificar,
                new DataParam("Login", user.Login),
                new DataParam("Nome", user.Nome),
                new DataParam("Email", user.Email));
            user.Admin = tbl.Read<bool>("Admin");
            user.Editor = tbl.Read<bool>("Editor");
            user.Atacado = tbl.Read<bool>("Atacado");
            user.Varejo = tbl.Read<bool>("Varejo");

            user.LoginSad = tbl.Read<string>("LoginSad");
        }

        public void ObterPerfil(AppUserData usuario)
        {
            DataTable tbl = DataContext.Load(AppUserScripts.ObterPerfil, new DataParam("Login", usuario.Login));
            usuario.Admin = tbl.Read<bool>("Admin");
            usuario.Editor = tbl.Read<bool>("Editor");
            usuario.Atacado = tbl.Read<bool>("Atacado");
            usuario.Varejo = tbl.Read<bool>("Varejo");
        }

        public List<AppUserData> Localizar(int modoVisualizacao, string filtro)
        {
            return DataContext.Load(
                AppUserScripts.Localizar,
                new DataParam("modoVisualizacao", modoVisualizacao),
                new DataParam("filtro", filtro)).ToObject<AppUserData>();
        }

        public int Incluir(string loginRede, string loginSad, bool admin, bool editor, bool atacado, bool varejo)
        {
            return DataContext.ExecuteNonQuery(
                AppUserScripts.Incluir, 
                new DataParam("loginRede", loginRede),
                new DataParam("loginSad", loginSad),
                new DataParam("admin", admin),
                new DataParam("editor", editor),
                new DataParam("atacado", atacado),
                new DataParam("varejo", varejo));
        }

        public void Atualizar(string login, bool admin, bool editor, bool atacado, bool varejo)
        {
            DataContext.ExecuteNonQuery(
                AppUserScripts.Atualizar,
                DataParam.Create("Login", login),
                DataParam.Create("Admin", admin),
                DataParam.Create("Editor", editor),
                new DataParam("atacado", atacado),
                new DataParam("varejo", varejo));
        }

        public int Atualizar(string login, string loginSad)
        {
            return DataContext.ExecuteNonQuery(
                AppUserScripts.AtualizarLoginSad,
                DataParam.Create("login", login),
                DataParam.Create("loginSad", loginSad));
        }

        public void Excluir(string login)
        {
            DataContext.ExecuteNonQuery(
                AppUserScripts.Excluir,
                DataParam.Create("Login", login));
        }
    }
}
