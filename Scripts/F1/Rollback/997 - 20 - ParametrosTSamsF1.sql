
go
print 'F1 - 20'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ParametrosTSamsF1]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ParametrosTSamsF1]
END

GO

