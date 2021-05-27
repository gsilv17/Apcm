
go
print 'F3 - 05 - CarrinhoItemLote'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoItemLote]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[CarrinhoItemLote]
END

GO

