
go
print 'F3 - 08 - XREF_BR_IF_ITEM'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XREF_BR_IF_ITEM]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[XREF_BR_IF_ITEM]
END

GO

