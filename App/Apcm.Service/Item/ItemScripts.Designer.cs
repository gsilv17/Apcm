//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Apcm.Service.Item {
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
    internal class ItemScripts {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal ItemScripts() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Apcm.Service.Item.ItemScripts", typeof(ItemScripts).Assembly);
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
        ///   Looks up a localized string similar to /*
        ///	Declare @filtro varchar(4000) = &apos;{&quot;Itens&quot;:[],&quot;Fornecedores&quot;:[],&quot;Estrutura&quot;:[{&quot;CodCategoria&quot;:23,&quot;CodSubcategoria&quot;:10,&quot;CodFineline&quot;:-1}],&quot;PossuiCross&quot;:-1,&quot;EmEdicao&quot;:-1}&apos;
        ///--*/
        ///
        ///Declare @Itens as table (item bigint)
        ///Declare @Fornecedores as table (vendor int)
        ///Declare @Estrutura as table (CodCategoria int, CodSubcategoria int, CodFineline int)
        ///Declare	@PossuiCross int, @EmEdicao int
        ///Declare @qtdItemUpc int, @qtdFornecedor int, @qtdEstrutura int
        ///
        ///Insert Into @Itens
        ///	Select item From
        ///		openjson(@fi [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string ContagemPesquisaPrateleira {
            get {
                return ResourceManager.GetString("ContagemPesquisaPrateleira", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to /*
        ///	Declare @filtro varchar(4000) = &apos;{&quot;Itens&quot;:[],&quot;Fornecedores&quot;:[],&quot;Estrutura&quot;:[{&quot;CodCategoria&quot;:23,&quot;CodSubcategoria&quot;:10,&quot;CodFineline&quot;:-1}],&quot;PossuiCross&quot;:-1,&quot;EmEdicao&quot;:-1}&apos;
        ///--*/
        ///
        ///Declare @Itens as table (item bigint)
        ///Declare @Fornecedores as table (vendor int)
        ///Declare @Estrutura as table (CodCategoria int, CodSubcategoria int, CodFineline int)
        ///Declare	@PossuiCross int, @EmEdicao int
        ///Declare @qtdItemUpc int, @qtdFornecedor int, @qtdEstrutura int
        ///
        ///Insert Into @Itens
        ///	Select item From
        ///		openjson(@fi [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string PesquisaPrateleira {
            get {
                return ResourceManager.GetString("PesquisaPrateleira", resourceCulture);
            }
        }
    }
}
