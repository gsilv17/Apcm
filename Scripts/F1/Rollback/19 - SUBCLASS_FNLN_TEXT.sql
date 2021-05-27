
go
print 'F1 - 19'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SUBCLASS_FNLN_TEXT]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[SUBCLASS_FNLN_TEXT]
END

GO

