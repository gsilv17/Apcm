
go
print 'F3 - 02 - Lote'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lote]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Lote]
END

GO

