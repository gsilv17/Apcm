
go
print 'F3 - 04 - CarrinhoItem'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoItem]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[CarrinhoItem]
END

GO