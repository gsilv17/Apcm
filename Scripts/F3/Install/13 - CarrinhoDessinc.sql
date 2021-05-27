/****** Object:  Table [dbo].[CarrinhoDessinc]    Script Date: 25/11/2020 17:15:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoDessinc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CarrinhoDessinc](
	[IdCarrinhoDessinc] [int] IDENTITY(1,1) NOT NULL,
	[IdCarrinho] [int] NOT NULL,
	[ProdutoNbr] [varchar](13) NOT NULL,
	[DhSelecionado] [datetime] NOT NULL,
	[DhRetorno] [datetime] NULL,
	[CodRetorno] [varchar](10) NULL,
	[MsgRetorno] [varchar](10) NULL,
 CONSTRAINT [PK_CarrinhoDessinc] PRIMARY KEY CLUSTERED 
(
	[IdCarrinhoDessinc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_CarrinhoDessinc_CodRetorno]    Script Date: 25/11/2020 17:15:09 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoDessinc]') AND name = N'IX_CarrinhoDessinc_CodRetorno')
CREATE NONCLUSTERED INDEX [IX_CarrinhoDessinc_CodRetorno] ON [dbo].[CarrinhoDessinc]
(
	[CodRetorno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_CarrinhoDessinc_ProdutoNbr]    Script Date: 25/11/2020 17:15:09 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoDessinc]') AND name = N'IX_CarrinhoDessinc_ProdutoNbr')
CREATE NONCLUSTERED INDEX [IX_CarrinhoDessinc_ProdutoNbr] ON [dbo].[CarrinhoDessinc]
(
	[ProdutoNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CarrinhoDessinc_Carrinho]') AND parent_object_id = OBJECT_ID(N'[dbo].[CarrinhoDessinc]'))
ALTER TABLE [dbo].[CarrinhoDessinc]  WITH CHECK ADD  CONSTRAINT [FK_CarrinhoDessinc_Carrinho] FOREIGN KEY([IdCarrinho])
REFERENCES [dbo].[Carrinho] ([IdCarrinho])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CarrinhoDessinc_Carrinho]') AND parent_object_id = OBJECT_ID(N'[dbo].[CarrinhoDessinc]'))
ALTER TABLE [dbo].[CarrinhoDessinc] CHECK CONSTRAINT [FK_CarrinhoDessinc_Carrinho]
GO


