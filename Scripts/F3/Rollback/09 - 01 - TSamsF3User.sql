
go
print 'F3 - 01 - TSamsF3User'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TSamsF3User]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[TSamsF3User]
END

GO

