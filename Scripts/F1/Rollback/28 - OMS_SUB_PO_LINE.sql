
go
print 'F1 - 28'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OMS_SUB_PO_LINE]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[OMS_SUB_PO_LINE]
END


GO


