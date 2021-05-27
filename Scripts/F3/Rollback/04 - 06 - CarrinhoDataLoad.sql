
go
print 'F3 - 06 - CarrinhoDataLoad'
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CarrinhoDataLoad]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[CarrinhoDataLoad]
END

GO

