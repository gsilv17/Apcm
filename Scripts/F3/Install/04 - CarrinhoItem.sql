
go
print 'F3 - 04 - CarrinhoItem'
go

/****** Object:  Table [dbo].[CarrinhoItem]    Script Date: 26/10/2020 09:12:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CarrinhoItem](
	[IdCarrinhoItem] [int] IDENTITY(1,1) NOT NULL,
	[IdCarrinho] [int] NOT NULL,
	[IdLoad] [int] NULL,
	[DhSelecionado] [datetime] NOT NULL,
	[EmEdicao] [bit] NOT NULL,
	[LoginAlteracaoEmEdicao] [varchar](10) NULL,
	[DhUltimaAlteracao] [datetime] NULL,
	[DhUltimaExportacaoTemplate] [datetime] NULL,
	[DhUltimaImportacaoTemplate] [datetime] NULL,
	[item_nbr] [int] NULL,
	[vendor_nbr] [int] NULL,
	[descrVendor] [varchar](300) NULL,
	[codCategoria] [int] NULL,
	[descrCategoria] [varchar](300) NULL,
	[codSubcategoria] [int] NULL,
	[descrSubcategoria] [varchar](300) NULL,
	[codFineline] [int] NULL,
	[descrFineline] [varchar](300) NULL,
	[ValidacaoTemplate] [varchar](4000) NULL,
	[CriticaSAD] [varchar](255) NULL,
	[upc_original] [varchar](15) NULL,
	[SamsCodDepartamento] [int] NULL,
	[SamsDescrDepartamento] [varchar](50) NULL,
	[DescrSecao] [varchar](50) NULL,
	[DescrLinha] [varchar](50) NULL,
	[DescrSublinha] [varchar](50) NULL,
	[Acao] [varchar](1) NULL,
	[TipoProc] [varchar](1) NULL,
	[produto_nbr] [varchar](13) NULL,
	[Emplg] [varchar](3) NULL,
	[Matric] [varchar](7) NULL,
	[item1_desc] [varchar](35) NULL,
	[Descsinal] [varchar](50) NULL,
	[Marc] [varchar](10) NULL,
	[Secao] [varchar](4) NULL,
	[Linha] [varchar](3) NULL,
	[Slinha] [varchar](3) NULL,
	[Itemsim] [varchar](8) NULL,
	[Comp] [varchar](4) NULL,
	[Embc] [varchar](3) NULL,
	[Conv] [varchar](7) NULL,
	[Embv] [varchar](3) NULL,
	[Larg] [varchar](4) NULL,
	[Altu] [varchar](4) NULL,
	[Peso] [varchar](8) NULL,
	[Pesoliq] [varchar](12) NULL,
	[Pesouv] [varchar](7) NULL,
	[Pesome] [varchar](1) NULL,
	[Tpeso] [varchar](1) NULL,
	[Tean] [varchar](2) NULL,
	[Cean] [varchar](13) NULL,
	[Eandg] [varchar](2) NULL,
	[Multpk] [varchar](1) NULL,
	[Upcr] [varchar](13) NULL,
	[Upcrdg] [varchar](2) NULL,
	[Teaneb] [varchar](2) NULL,
	[Ceaneb] [varchar](15) NULL,
	[Mulean] [varchar](1) NULL,
	[Ceantel] [varchar](13) NULL,
	[Eandgtel] [varchar](2) NULL,
	[Qtdinemb] [varchar](10) NULL,
	[Tprod] [varchar](1) NULL,
	[Ra] [varchar](1) NULL,
	[Oimpo] [varchar](3) NULL,
	[Lbranc] [varchar](1) NULL,
	[Kprom] [varchar](1) NULL,
	[Refb] [varchar](13) NULL,
	[Categ] [varchar](1) NULL,
	[Comis] [varchar](1) NULL,
	[Restv] [varchar](1) NULL,
	[Identf] [varchar](12) NULL,
	[Tidentf] [varchar](1) NULL,
	[Edi] [varchar](1) NULL,
	[Cvalid] [varchar](1) NULL,
	[ValProd] [varchar](4) NULL,
	[Medtp] [varchar](1) NULL,
	[Tmed] [varchar](1) NULL,
	[Clasfis] [varchar](15) NULL,
	[Clasipi] [varchar](5) NULL,
	[TelVend] [varchar](1) NULL,
	[cdarea] [varchar](3) NULL,
	[Tamp] [varchar](8) NULL,
	[Unidp] [varchar](3) NULL,
	[Qtdep] [varchar](4) NULL,
	[Tref] [varchar](8) NULL,
	[Uref] [varchar](3) NULL,
	[Vigpcr] [varchar](1) NULL,
	[Dtvprc] [varchar](7) NULL,
	[Pprc] [varchar](10) NULL,
	[Dscprc] [varchar](5) NULL,
	[Bofprc] [varchar](5) NULL,
	[Cpmprc] [varchar](1) NULL,
	[Trnprc] [varchar](5) NULL,
	[Tdeprc] [varchar](1) NULL,
	[Vdeprc] [varchar](9) NULL,
	[Tipiprc] [varchar](1) NULL,
	[Vipiprc] [varchar](9) NULL,
	[Tfrcprc] [varchar](1) NULL,
	[Vfrcprc] [varchar](9) NULL,
	[Tevtprc] [varchar](1) NULL,
	[Vevtprc] [varchar](9) NULL,
	[Tipieprc] [varchar](1) NULL,
	[Vipieprc] [varchar](9) NULL,
	[Tfrtprc] [varchar](1) NULL,
	[Vfrtprc] [varchar](9) NULL,
	[Opcpfl_1] [varchar](1) NULL,
	[Filpfl_1] [varchar](5) NULL,
	[Marpfl_1] [varchar](6) NULL,
	[Fornpfl_1] [varchar](8) NULL,
	[Locpfl_1] [varchar](2) NULL,
	[Imppfl_1] [varchar](1) NULL,
	[Ufpfl_1] [varchar](2) NULL,
	[Ntpfl_1] [varchar](2) NULL,
	[Sazpfl_1] [varchar](1) NULL,
	[Sbgpfl_1] [varchar](1) NULL,
	[Sitpfl_1] [varchar](1) NULL,
	[Susppfl_1] [varchar](1) NULL,
	[Msuppfl_1] [varchar](3) NULL,
	[Claspfl_1] [varchar](1) NULL,
	[Cestpfl_1] [varchar](1) NULL,
	[Cmpupfl_1] [varchar](1) NULL,
	[Referpfl_1] [varchar](15) NULL,
	[Opcpfl_2] [varchar](1) NULL,
	[Filpfl_2] [varchar](5) NULL,
	[Marpfl_2] [varchar](6) NULL,
	[Fornpfl_2] [varchar](8) NULL,
	[Locpfl_2] [varchar](2) NULL,
	[Imppfl_2] [varchar](1) NULL,
	[Ufpfl_2] [varchar](2) NULL,
	[Ntpfl_2] [varchar](2) NULL,
	[Sazpfl_2] [varchar](1) NULL,
	[Sbgpfl_2] [varchar](1) NULL,
	[Sitpfl_2] [varchar](1) NULL,
	[Susppfl_2] [varchar](1) NULL,
	[Msuppfl_2] [varchar](3) NULL,
	[Claspfl_2] [varchar](1) NULL,
	[Cestpfl_2] [varchar](1) NULL,
	[Cmpupfl_2] [varchar](1) NULL,
	[Referpfl_2] [varchar](15) NULL,
	[Opcpfl_3] [varchar](1) NULL,
	[Filpfl_3] [varchar](5) NULL,
	[Marpfl_3] [varchar](6) NULL,
	[Fornpfl_3] [varchar](8) NULL,
	[Locpfl_3] [varchar](2) NULL,
	[Imppfl_3] [varchar](1) NULL,
	[Ufpfl_3] [varchar](2) NULL,
	[Ntpfl_3] [varchar](2) NULL,
	[Sazpfl_3] [varchar](1) NULL,
	[Sbgpfl_3] [varchar](1) NULL,
	[Sitpfl_3] [varchar](1) NULL,
	[Susppfl_3] [varchar](1) NULL,
	[Msuppfl_3] [varchar](3) NULL,
	[Claspfl_3] [varchar](1) NULL,
	[Cestpfl_3] [varchar](1) NULL,
	[Cmpupfl_3] [varchar](1) NULL,
	[Referpfl_3] [varchar](15) NULL,
	[Opcpfl_4] [varchar](1) NULL,
	[Filpfl_4] [varchar](5) NULL,
	[Marpfl_4] [varchar](6) NULL,
	[Fornpfl_4] [varchar](8) NULL,
	[Locpfl_4] [varchar](2) NULL,
	[Imppfl_4] [varchar](1) NULL,
	[Ufpfl_4] [varchar](2) NULL,
	[Ntpfl_4] [varchar](2) NULL,
	[Sazpfl_4] [varchar](1) NULL,
	[Sbgpfl_4] [varchar](1) NULL,
	[Sitpfl_4] [varchar](1) NULL,
	[Susppfl_4] [varchar](1) NULL,
	[Msuppfl_4] [varchar](3) NULL,
	[Claspfl_4] [varchar](1) NULL,
	[Cestpfl_4] [varchar](1) NULL,
	[Cmpupfl_4] [varchar](1) NULL,
	[Referpfl_4] [varchar](15) NULL,
	[Opcpfl_5] [varchar](1) NULL,
	[Filpfl_5] [varchar](5) NULL,
	[Marpfl_5] [varchar](6) NULL,
	[Fornpfl_5] [varchar](8) NULL,
	[Locpfl_5] [varchar](2) NULL,
	[Imppfl_5] [varchar](1) NULL,
	[Ufpfl_5] [varchar](2) NULL,
	[Ntpfl_5] [varchar](2) NULL,
	[Sazpfl_5] [varchar](1) NULL,
	[Sbgpfl_5] [varchar](1) NULL,
	[Sitpfl_5] [varchar](1) NULL,
	[Susppfl_5] [varchar](1) NULL,
	[Msuppfl_5] [varchar](3) NULL,
	[Claspfl_5] [varchar](1) NULL,
	[Cestpfl_5] [varchar](1) NULL,
	[Cmpupfl_5] [varchar](1) NULL,
	[Referpfl_5] [varchar](15) NULL,
	[Opcpfl_6] [varchar](1) NULL,
	[Filpfl_6] [varchar](5) NULL,
	[Marpfl_6] [varchar](6) NULL,
	[Fornpfl_6] [varchar](8) NULL,
	[Locpfl_6] [varchar](2) NULL,
	[Imppfl_6] [varchar](1) NULL,
	[Ufpfl_6] [varchar](2) NULL,
	[Ntpfl_6] [varchar](2) NULL,
	[Sazpfl_6] [varchar](1) NULL,
	[Sbgpfl_6] [varchar](1) NULL,
	[Sitpfl_6] [varchar](1) NULL,
	[Susppfl_6] [varchar](1) NULL,
	[Msuppfl_6] [varchar](3) NULL,
	[Claspfl_6] [varchar](1) NULL,
	[Cestpfl_6] [varchar](1) NULL,
	[Cmpupfl_6] [varchar](1) NULL,
	[Referpfl_6] [varchar](15) NULL,
	[Opcpfl_7] [varchar](1) NULL,
	[Filpfl_7] [varchar](5) NULL,
	[Marpfl_7] [varchar](6) NULL,
	[Fornpfl_7] [varchar](8) NULL,
	[Locpfl_7] [varchar](2) NULL,
	[Imppfl_7] [varchar](1) NULL,
	[Ufpfl_7] [varchar](2) NULL,
	[Ntpfl_7] [varchar](2) NULL,
	[Sazpfl_7] [varchar](1) NULL,
	[Sbgpfl_7] [varchar](1) NULL,
	[Sitpfl_7] [varchar](1) NULL,
	[Susppfl_7] [varchar](1) NULL,
	[Msuppfl_7] [varchar](3) NULL,
	[Claspfl_7] [varchar](1) NULL,
	[Cestpfl_7] [varchar](1) NULL,
	[Cmpupfl_7] [varchar](1) NULL,
	[Referpfl_7] [varchar](15) NULL,
	[Opcpfl_8] [varchar](1) NULL,
	[Filpfl_8] [varchar](5) NULL,
	[Marpfl_8] [varchar](6) NULL,
	[Fornpfl_8] [varchar](8) NULL,
	[Locpfl_8] [varchar](2) NULL,
	[Imppfl_8] [varchar](1) NULL,
	[Ufpfl_8] [varchar](2) NULL,
	[Ntpfl_8] [varchar](2) NULL,
	[Sazpfl_8] [varchar](1) NULL,
	[Sbgpfl_8] [varchar](1) NULL,
	[Sitpfl_8] [varchar](1) NULL,
	[Susppfl_8] [varchar](1) NULL,
	[Msuppfl_8] [varchar](3) NULL,
	[Claspfl_8] [varchar](1) NULL,
	[Cestpfl_8] [varchar](1) NULL,
	[Cmpupfl_8] [varchar](1) NULL,
	[Referpfl_8] [varchar](15) NULL,
	[Opcpfl_9] [varchar](1) NULL,
	[Filpfl_9] [varchar](5) NULL,
	[Marpfl_9] [varchar](6) NULL,
	[Fornpfl_9] [varchar](8) NULL,
	[Locpfl_9] [varchar](2) NULL,
	[Imppfl_9] [varchar](1) NULL,
	[Ufpfl_9] [varchar](2) NULL,
	[Ntpfl_9] [varchar](2) NULL,
	[Sazpfl_9] [varchar](1) NULL,
	[Sbgpfl_9] [varchar](1) NULL,
	[Sitpfl_9] [varchar](1) NULL,
	[Susppfl_9] [varchar](1) NULL,
	[Msuppfl_9] [varchar](3) NULL,
	[Claspfl_9] [varchar](1) NULL,
	[Cestpfl_9] [varchar](1) NULL,
	[Cmpupfl_9] [varchar](1) NULL,
	[Referpfl_9] [varchar](15) NULL,
	[Opcpfl_10] [varchar](1) NULL,
	[Filpfl_10] [varchar](5) NULL,
	[Marpfl_10] [varchar](6) NULL,
	[Fornpfl_10] [varchar](8) NULL,
	[Locpfl_10] [varchar](2) NULL,
	[Imppfl_10] [varchar](1) NULL,
	[Ufpfl_10] [varchar](2) NULL,
	[Ntpfl_10] [varchar](2) NULL,
	[Sazpfl_10] [varchar](1) NULL,
	[Sbgpfl_10] [varchar](1) NULL,
	[Sitpfl_10] [varchar](1) NULL,
	[Susppfl_10] [varchar](1) NULL,
	[Msuppfl_10] [varchar](3) NULL,
	[Claspfl_10] [varchar](1) NULL,
	[Cestpfl_10] [varchar](1) NULL,
	[Cmpupfl_10] [varchar](1) NULL,
	[Referpfl_10] [varchar](15) NULL,
	[Opcpfl_11] [varchar](1) NULL,
	[Filpfl_11] [varchar](5) NULL,
	[Marpfl_11] [varchar](6) NULL,
	[Fornpfl_11] [varchar](8) NULL,
	[Locpfl_11] [varchar](2) NULL,
	[Imppfl_11] [varchar](1) NULL,
	[Ufpfl_11] [varchar](2) NULL,
	[Ntpfl_11] [varchar](2) NULL,
	[Sazpfl_11] [varchar](1) NULL,
	[Sbgpfl_11] [varchar](1) NULL,
	[Sitpfl_11] [varchar](1) NULL,
	[Susppfl_11] [varchar](1) NULL,
	[Msuppfl_11] [varchar](3) NULL,
	[Claspfl_11] [varchar](1) NULL,
	[Cestpfl_11] [varchar](1) NULL,
	[Cmpupfl_11] [varchar](1) NULL,
	[Referpfl_11] [varchar](15) NULL,
	[Opcpfl_12] [varchar](1) NULL,
	[Filpfl_12] [varchar](5) NULL,
	[Marpfl_12] [varchar](6) NULL,
	[Fornpfl_12] [varchar](8) NULL,
	[Locpfl_12] [varchar](2) NULL,
	[Imppfl_12] [varchar](1) NULL,
	[Ufpfl_12] [varchar](2) NULL,
	[Ntpfl_12] [varchar](2) NULL,
	[Sazpfl_12] [varchar](1) NULL,
	[Sbgpfl_12] [varchar](1) NULL,
	[Sitpfl_12] [varchar](1) NULL,
	[Susppfl_12] [varchar](1) NULL,
	[Msuppfl_12] [varchar](3) NULL,
	[Claspfl_12] [varchar](1) NULL,
	[Cestpfl_12] [varchar](1) NULL,
	[Cmpupfl_12] [varchar](1) NULL,
	[Referpfl_12] [varchar](15) NULL,
	[Opcpfl_13] [varchar](1) NULL,
	[Filpfl_13] [varchar](5) NULL,
	[Marpfl_13] [varchar](6) NULL,
	[Fornpfl_13] [varchar](8) NULL,
	[Locpfl_13] [varchar](2) NULL,
	[Imppfl_13] [varchar](1) NULL,
	[Ufpfl_13] [varchar](2) NULL,
	[Ntpfl_13] [varchar](2) NULL,
	[Sazpfl_13] [varchar](1) NULL,
	[Sbgpfl_13] [varchar](1) NULL,
	[Sitpfl_13] [varchar](1) NULL,
	[Susppfl_13] [varchar](1) NULL,
	[Msuppfl_13] [varchar](3) NULL,
	[Claspfl_13] [varchar](1) NULL,
	[Cestpfl_13] [varchar](1) NULL,
	[Cmpupfl_13] [varchar](1) NULL,
	[Referpfl_13] [varchar](15) NULL,
	[Opcpfl_14] [varchar](1) NULL,
	[Filpfl_14] [varchar](5) NULL,
	[Marpfl_14] [varchar](6) NULL,
	[Fornpfl_14] [varchar](8) NULL,
	[Locpfl_14] [varchar](2) NULL,
	[Imppfl_14] [varchar](1) NULL,
	[Ufpfl_14] [varchar](2) NULL,
	[Ntpfl_14] [varchar](2) NULL,
	[Sazpfl_14] [varchar](1) NULL,
	[Sbgpfl_14] [varchar](1) NULL,
	[Sitpfl_14] [varchar](1) NULL,
	[Susppfl_14] [varchar](1) NULL,
	[Msuppfl_14] [varchar](3) NULL,
	[Claspfl_14] [varchar](1) NULL,
	[Cestpfl_14] [varchar](1) NULL,
	[Cmpupfl_14] [varchar](1) NULL,
	[Referpfl_14] [varchar](15) NULL,
	[Opcpfl_15] [varchar](1) NULL,
	[Filpfl_15] [varchar](5) NULL,
	[Marpfl_15] [varchar](6) NULL,
	[Fornpfl_15] [varchar](8) NULL,
	[Locpfl_15] [varchar](2) NULL,
	[Imppfl_15] [varchar](1) NULL,
	[Ufpfl_15] [varchar](2) NULL,
	[Ntpfl_15] [varchar](2) NULL,
	[Sazpfl_15] [varchar](1) NULL,
	[Sbgpfl_15] [varchar](1) NULL,
	[Sitpfl_15] [varchar](1) NULL,
	[Susppfl_15] [varchar](1) NULL,
	[Msuppfl_15] [varchar](3) NULL,
	[Claspfl_15] [varchar](1) NULL,
	[Cestpfl_15] [varchar](1) NULL,
	[Cmpupfl_15] [varchar](1) NULL,
	[Referpfl_15] [varchar](15) NULL,
	[Opcpfl_16] [varchar](1) NULL,
	[Filpfl_16] [varchar](5) NULL,
	[Marpfl_16] [varchar](6) NULL,
	[Fornpfl_16] [varchar](8) NULL,
	[Locpfl_16] [varchar](2) NULL,
	[Imppfl_16] [varchar](1) NULL,
	[Ufpfl_16] [varchar](2) NULL,
	[Ntpfl_16] [varchar](2) NULL,
	[Sazpfl_16] [varchar](1) NULL,
	[Sbgpfl_16] [varchar](1) NULL,
	[Sitpfl_16] [varchar](1) NULL,
	[Susppfl_16] [varchar](1) NULL,
	[Msuppfl_16] [varchar](3) NULL,
	[Claspfl_16] [varchar](1) NULL,
	[Cestpfl_16] [varchar](1) NULL,
	[Cmpupfl_16] [varchar](1) NULL,
	[Referpfl_16] [varchar](15) NULL,
	[Opcpfl_17] [varchar](1) NULL,
	[Filpfl_17] [varchar](5) NULL,
	[Marpfl_17] [varchar](6) NULL,
	[Fornpfl_17] [varchar](8) NULL,
	[Locpfl_17] [varchar](2) NULL,
	[Imppfl_17] [varchar](1) NULL,
	[Ufpfl_17] [varchar](2) NULL,
	[Ntpfl_17] [varchar](2) NULL,
	[Sazpfl_17] [varchar](1) NULL,
	[Sbgpfl_17] [varchar](1) NULL,
	[Sitpfl_17] [varchar](1) NULL,
	[Susppfl_17] [varchar](1) NULL,
	[Msuppfl_17] [varchar](3) NULL,
	[Claspfl_17] [varchar](1) NULL,
	[Cestpfl_17] [varchar](1) NULL,
	[Cmpupfl_17] [varchar](1) NULL,
	[Referpfl_17] [varchar](15) NULL,
	[Opcpfl_18] [varchar](1) NULL,
	[Filpfl_18] [varchar](5) NULL,
	[Marpfl_18] [varchar](6) NULL,
	[Fornpfl_18] [varchar](8) NULL,
	[Locpfl_18] [varchar](2) NULL,
	[Imppfl_18] [varchar](1) NULL,
	[Ufpfl_18] [varchar](2) NULL,
	[Ntpfl_18] [varchar](2) NULL,
	[Sazpfl_18] [varchar](1) NULL,
	[Sbgpfl_18] [varchar](1) NULL,
	[Sitpfl_18] [varchar](1) NULL,
	[Susppfl_18] [varchar](1) NULL,
	[Msuppfl_18] [varchar](3) NULL,
	[Claspfl_18] [varchar](1) NULL,
	[Cestpfl_18] [varchar](1) NULL,
	[Cmpupfl_18] [varchar](1) NULL,
	[Referpfl_18] [varchar](15) NULL,
	[Opcpfl_19] [varchar](1) NULL,
	[Filpfl_19] [varchar](5) NULL,
	[Marpfl_19] [varchar](6) NULL,
	[Fornpfl_19] [varchar](8) NULL,
	[Locpfl_19] [varchar](2) NULL,
	[Imppfl_19] [varchar](1) NULL,
	[Ufpfl_19] [varchar](2) NULL,
	[Ntpfl_19] [varchar](2) NULL,
	[Sazpfl_19] [varchar](1) NULL,
	[Sbgpfl_19] [varchar](1) NULL,
	[Sitpfl_19] [varchar](1) NULL,
	[Susppfl_19] [varchar](1) NULL,
	[Msuppfl_19] [varchar](3) NULL,
	[Claspfl_19] [varchar](1) NULL,
	[Cestpfl_19] [varchar](1) NULL,
	[Cmpupfl_19] [varchar](1) NULL,
	[Referpfl_19] [varchar](15) NULL,
	[Opcpfl_20] [varchar](1) NULL,
	[Filpfl_20] [varchar](5) NULL,
	[Marpfl_20] [varchar](6) NULL,
	[Fornpfl_20] [varchar](8) NULL,
	[Locpfl_20] [varchar](2) NULL,
	[Imppfl_20] [varchar](1) NULL,
	[Ufpfl_20] [varchar](2) NULL,
	[Ntpfl_20] [varchar](2) NULL,
	[Sazpfl_20] [varchar](1) NULL,
	[Sbgpfl_20] [varchar](1) NULL,
	[Sitpfl_20] [varchar](1) NULL,
	[Susppfl_20] [varchar](1) NULL,
	[Msuppfl_20] [varchar](3) NULL,
	[Claspfl_20] [varchar](1) NULL,
	[Cestpfl_20] [varchar](1) NULL,
	[Cmpupfl_20] [varchar](1) NULL,
	[Referpfl_20] [varchar](15) NULL,
	[Opcpfl_21] [varchar](1) NULL,
	[Filpfl_21] [varchar](5) NULL,
	[Marpfl_21] [varchar](6) NULL,
	[Fornpfl_21] [varchar](8) NULL,
	[Locpfl_21] [varchar](2) NULL,
	[Imppfl_21] [varchar](1) NULL,
	[Ufpfl_21] [varchar](2) NULL,
	[Ntpfl_21] [varchar](2) NULL,
	[Sazpfl_21] [varchar](1) NULL,
	[Sbgpfl_21] [varchar](1) NULL,
	[Sitpfl_21] [varchar](1) NULL,
	[Susppfl_21] [varchar](1) NULL,
	[Msuppfl_21] [varchar](3) NULL,
	[Claspfl_21] [varchar](1) NULL,
	[Cestpfl_21] [varchar](1) NULL,
	[Cmpupfl_21] [varchar](1) NULL,
	[Referpfl_21] [varchar](15) NULL,
	[Opcpfl_22] [varchar](1) NULL,
	[Filpfl_22] [varchar](5) NULL,
	[Marpfl_22] [varchar](6) NULL,
	[Fornpfl_22] [varchar](8) NULL,
	[Locpfl_22] [varchar](2) NULL,
	[Imppfl_22] [varchar](1) NULL,
	[Ufpfl_22] [varchar](2) NULL,
	[Ntpfl_22] [varchar](2) NULL,
	[Sazpfl_22] [varchar](1) NULL,
	[Sbgpfl_22] [varchar](1) NULL,
	[Sitpfl_22] [varchar](1) NULL,
	[Susppfl_22] [varchar](1) NULL,
	[Msuppfl_22] [varchar](3) NULL,
	[Claspfl_22] [varchar](1) NULL,
	[Cestpfl_22] [varchar](1) NULL,
	[Cmpupfl_22] [varchar](1) NULL,
	[Referpfl_22] [varchar](15) NULL,
 CONSTRAINT [PK_CarrinhoItem] PRIMARY KEY CLUSTERED 
(
	[IdCarrinhoItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_CarrinhoItem_item_nbr]    Script Date: 26/10/2020 09:12:51 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoItem]') AND name = N'IX_CarrinhoItem_item_nbr')
CREATE NONCLUSTERED INDEX [IX_CarrinhoItem_item_nbr] ON [dbo].[CarrinhoItem]
(
	[item_nbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_CarrinhoItem_produto_nbr]    Script Date: 26/10/2020 09:12:51 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoItem]') AND name = N'IX_CarrinhoItem_produto_nbr')
CREATE NONCLUSTERED INDEX [IX_CarrinhoItem_produto_nbr] ON [dbo].[CarrinhoItem]
(
	[produto_nbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CarrinhoItem_LoadTSams]') AND parent_object_id = OBJECT_ID(N'[dbo].[CarrinhoItem]'))
ALTER TABLE [dbo].[CarrinhoItem]  WITH CHECK ADD  CONSTRAINT [FK_CarrinhoItem_LoadTSams] FOREIGN KEY([IdLoad])
REFERENCES [dbo].[LoadTSams] ([IdLoad])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CarrinhoItem_LoadTSams]') AND parent_object_id = OBJECT_ID(N'[dbo].[CarrinhoItem]'))
ALTER TABLE [dbo].[CarrinhoItem] CHECK CONSTRAINT [FK_CarrinhoItem_LoadTSams]
GO


