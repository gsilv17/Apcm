
go
print 'F1 - 25'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OMS_PURCHASE_ORDER]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[OMS_PURCHASE_ORDER]
END

GO

