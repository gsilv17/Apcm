
go
print 'F2 - 01 - Transformacoes'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Transformacoes]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Transformacoes]
END

GO

