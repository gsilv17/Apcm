﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Apcm.Service.Mapa {
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
    internal class MapaScripts {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal MapaScripts() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Apcm.Service.Mapa.MapaScripts", typeof(MapaScripts).Assembly);
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
        ///   Looks up a localized string similar to Select
        ///	m.EntidadeOrigem, m.CampoOrigem, m.CampoCarrinhoItem
        ///From
        ///	Mapa as m
        ///Where
        ///	m.EntidadeOrigem is not null
        ///.
        /// </summary>
        internal static string MapaCarrinhoItem {
            get {
                return ResourceManager.GetString("MapaCarrinhoItem", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Select
        ///	CampoCarrinhoItem, CampoJSon, GrupoJSon, OrdemJSon, Tamanho
        ///From
        ///	Mapa
        ///Where
        ///	OrdemJSon is not null
        ///Order By
        ///	OrdemJSon Asc.
        /// </summary>
        internal static string MapaJSon {
            get {
                return ResourceManager.GetString("MapaJSon", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Select
        ///	CampoCarrinhoItem, NomeColuna, Ordem, 
        ///	Grupo, Tipo, Tamanho, 
        ///	Precisao, Obrigatorio, PodeAlterar, Descricao
        ///From
        ///	Mapa
        ///Where
        ///	Ordem is not null
        ///Order By
        ///	Ordem Asc.
        /// </summary>
        internal static string MapaTemplate {
            get {
                return ResourceManager.GetString("MapaTemplate", resourceCulture);
            }
        }
    }
}