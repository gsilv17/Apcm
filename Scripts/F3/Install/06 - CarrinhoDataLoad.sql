
go
print 'F3 - 06 - CarrinhoDataLoad'
go


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoDataLoad]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CarrinhoDataLoad](
	[login] [varchar](10) NOT NULL,
	[idLoad] [int] NOT NULL,
	[item_nbr] [int] NOT NULL
) ON [PRIMARY]
END
GO

SET ANSI_PADDING ON

GO

/****** Object:  Index [IX_CarrinhoDataLoad]    Script Date: 02/03/2020 10:18:03 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoDataLoad]') AND name = N'IX_CarrinhoDataLoad')
CREATE NONCLUSTERED INDEX [IX_CarrinhoDataLoad] ON [dbo].[CarrinhoDataLoad]
(
	[login] ASC,
	[idLoad] ASC,
	[item_nbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


