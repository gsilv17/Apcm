//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Apcm.Service.AppUser {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "15.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    internal class AppUserScripts {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal AppUserScripts() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Apcm.Service.AppUser.AppUserScripts", typeof(AppUserScripts).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Update TSamsF3User Set [Admin] = @Admin, [Editor] = @Editor Where [Login] = @Login.
        /// </summary>
        internal static string Atualizar {
            get {
                return ResourceManager.GetString("Atualizar", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to -- Declare @login varchar(10), @loginSad varchar(10)
        ///
        ///If Not Exists ( Select 1 From TSamsF3User where [Login] &lt;&gt; @login And LoginSad = @loginSad )
        ///	Begin
        ///		Update TSamsF3User Set LoginSad = @loginSad Where [Login] = @Login
        ///	End.
        /// </summary>
        internal static string AtualizarLoginSad {
            get {
                return ResourceManager.GetString("AtualizarLoginSad", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Delete From TSamsF3User Where [Login] = @Login.
        /// </summary>
        internal static string Excluir {
            get {
                return ResourceManager.GetString("Excluir", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to If not exists(Select top 1 1 From TSamsF3User Where [Login] = @loginRede Or [LoginSad] = @loginSad)
        ///Begin
        ///	Insert Into TSamsF3User (
        ///			[Login], [LoginSad], [Admin], [Editor]
        ///		) Values (
        ///			@loginRede, @loginSad, @admin, @editor
        ///		)
        ///End.
        /// </summary>
        internal static string Incluir {
            get {
                return ResourceManager.GetString("Incluir", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Select
        ///	[Login], [LoginSad], [Nome], [Email], [Admin], [Editor]
        ///From
        ///	TSamsF3User as u
        ///Where
        ///	(
        ///		@modoVisualizacao = 0 -- Todos
        ///		Or ( @modoVisualizacao = 1 And u.[Admin] = 0 And u.Editor = 0 ) -- Novos
        ///		Or ( @modoVisualizacao = 2 And u.[Admin] = 1 ) -- Administradores
        ///		Or ( @modoVisualizacao = 3 And u.Editor = 1 ) -- Editores
        ///	)
        ///	And 
        ///	(
        ///		isnull(@filtro, &apos;&apos;) = &apos;&apos;
        ///		Or u.[Login] like &apos;%&apos; + @filtro + &apos;%&apos;
        ///		Or u.[Nome] like &apos;%&apos; + @filtro + &apos;%&apos;
        ///		Or u.[Email] like &apos;%&apos; + @filtro + &apos;%&apos;
        ///	)
        ///O [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string Localizar {
            get {
                return ResourceManager.GetString("Localizar", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Select [Admin], [Editor] From TSamsF3User Where [Login] = @Login.
        /// </summary>
        internal static string ObterPerfil {
            get {
                return ResourceManager.GetString("ObterPerfil", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to if exists(select top 1 1 from TSamsF3User Where [Login] = @Login)
        ///	Begin
        ///		Update TSamsF3User Set 
        ///			Nome = Case When ISNULL(@Nome, &apos;&apos;) = &apos;&apos; Then Nome Else @Nome End,
        ///			Email = Case When ISNULL(@Email, &apos;&apos;) = &apos;&apos; Then Email Else @Email End,
        ///			dtUltimoAcesso = GETDATE() 
        ///		Where 
        ///			[Login] = @Login
        ///
        ///		Select [Admin], [Editor], [LoginSad] From TSamsF3User Where [Login] = @Login
        ///	End
        ///Else
        ///	Begin
        ///		Select 0 as [Admin], 0 as [Editor], &apos;&apos; as [LoginSad] From TSamsF3User
        ///	End.
        /// </summary>
        internal static string Verificar {
            get {
                return ResourceManager.GetString("Verificar", resourceCulture);
            }
        }
    }
}
