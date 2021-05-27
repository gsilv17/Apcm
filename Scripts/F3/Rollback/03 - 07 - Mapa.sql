
go
print 'F3 - 07 - Mapa'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Mapa]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[Mapa]
END

GO

