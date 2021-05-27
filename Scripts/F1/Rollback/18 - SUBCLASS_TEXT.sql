
go
print 'F1 - 18'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SUBCLASS_TEXT]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[SUBCLASS_TEXT]
END

GO

