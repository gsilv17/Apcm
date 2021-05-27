
go
print 'F1 - 26'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OMS_SUB_PO]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[OMS_SUB_PO]
END


GO


