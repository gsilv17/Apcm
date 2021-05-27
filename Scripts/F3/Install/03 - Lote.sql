
go
print 'F3 - 02 - Lote'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lote]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Lote](
	[IdLote] [int] IDENTITY(1,1) NOT NULL,
	[IdCarrinho] [int] NOT NULL,
	[DhEnvio] [datetime] NOT NULL,
	[NumeroLote] [varchar](20) NOT NULL,
	[DhRetorno] [datetime] NULL,
	[StatusRetorno] [varchar](255) NULL,
 CONSTRAINT [PK_Lote] PRIMARY KEY CLUSTERED 
(
	[IdLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_Lote]    Script Date: 20/08/2020 08:33:21 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Lote]') AND name = N'IX_Lote')
CREATE UNIQUE NONCLUSTERED INDEX [IX_Lote] ON [dbo].[Lote]
(
	[NumeroLote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Lote_Carrinho]') AND parent_object_id = OBJECT_ID(N'[dbo].[Lote]'))
ALTER TABLE [dbo].[Lote]  WITH CHECK ADD  CONSTRAINT [FK_Lote_Carrinho] FOREIGN KEY([IdCarrinho])
REFERENCES [dbo].[Carrinho] ([IdCarrinho])
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Lote_Carrinho]') AND parent_object_id = OBJECT_ID(N'[dbo].[Lote]'))
ALTER TABLE [dbo].[Lote] CHECK CONSTRAINT [FK_Lote_Carrinho]
GO