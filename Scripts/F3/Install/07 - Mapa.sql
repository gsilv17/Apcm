

go
print 'F3 - 07 - Mapa'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Mapa]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Mapa](
	[IdMapa] [int] IDENTITY(1,1) NOT NULL,
	[EntidadeOrigem] [varchar](50) NULL,
	[CampoOrigem] [varchar](50) NULL,
	[CampoCarrinhoItem] [varchar](50) NULL,
	[NomeColuna] [varchar](255) NULL,
	[Ordem] [int] NULL,
	[Grupo] [varchar](255) NULL,
	[Tipo] [char](1) NOT NULL,
	[Tamanho] [int] NULL,
	[Precisao] [int] NULL,
	[Obrigatorio] [bit] NOT NULL,
	[PodeAlterar] [bit] NOT NULL,
	[CampoJSon] [varchar](50) NULL,
	[GrupoJSon] [varchar](50) NULL,
	[OrdemJSon] [int] NULL,
	[Descricao] [varchar](255) NULL,
 CONSTRAINT [PK_Mapa] PRIMARY KEY CLUSTERED 
(
	[IdMapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


