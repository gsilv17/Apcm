
go
print 'F3 - 05 - CarrinhoItemLote'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoItemLote]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CarrinhoItemLote](
	[IdCarrinhoItemLote] [int] IDENTITY(1,1) NOT NULL,
	[IdCarrinhoItem] [int] NOT NULL,
	[IdLote] [int] NOT NULL,
	[CodRetorno] [varchar](10) NOT NULL,
	[StatusRetorno] [varchar](255) NOT NULL,
	[Filial] [int] NULL,
 CONSTRAINT [PK_CarrinhoItemLote] PRIMARY KEY CLUSTERED 
(
	[IdCarrinhoItemLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

/****** Object:  Index [IX_CarrinhoItemLote]    Script Date: 03/08/2020 16:32:10 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoItemLote]') AND name = N'IX_CarrinhoItemLote')
CREATE UNIQUE NONCLUSTERED INDEX [IX_CarrinhoItemLote] ON [dbo].[CarrinhoItemLote]
(
	[IdCarrinhoItem] ASC,
	[IdLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CarrinhoItemLote_CarrinhoItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[CarrinhoItemLote]'))
ALTER TABLE [dbo].[CarrinhoItemLote]  WITH CHECK ADD  CONSTRAINT [FK_CarrinhoItemLote_CarrinhoItem] FOREIGN KEY([IdCarrinhoItem])
REFERENCES [dbo].[CarrinhoItem] ([IdCarrinhoItem])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CarrinhoItemLote_CarrinhoItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[CarrinhoItemLote]'))
ALTER TABLE [dbo].[CarrinhoItemLote] CHECK CONSTRAINT [FK_CarrinhoItemLote_CarrinhoItem]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CarrinhoItemLote_Lote]') AND parent_object_id = OBJECT_ID(N'[dbo].[CarrinhoItemLote]'))
ALTER TABLE [dbo].[CarrinhoItemLote]  WITH CHECK ADD  CONSTRAINT [FK_CarrinhoItemLote_Lote] FOREIGN KEY([IdLote])
REFERENCES [dbo].[Lote] ([IdLote])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CarrinhoItemLote_Lote]') AND parent_object_id = OBJECT_ID(N'[dbo].[CarrinhoItemLote]'))
ALTER TABLE [dbo].[CarrinhoItemLote] CHECK CONSTRAINT [FK_CarrinhoItemLote_Lote]
GO

