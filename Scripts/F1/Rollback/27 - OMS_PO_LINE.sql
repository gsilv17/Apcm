
go
print 'F1 - 27'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OMS_PO_LINE]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[OMS_PO_LINE]
END

GO


