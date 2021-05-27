
go
print 'F3 - 03 - Carrinho'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Carrinho]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Carrinho]
END

GO

