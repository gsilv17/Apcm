
go
print 'F3 - 09 - XREF_BR_IF_ITEM_LOG'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XREF_BR_IF_ITEM_LOG]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[XREF_BR_IF_ITEM_LOG]
END

GO

