
go
print 'F1 - 21'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UPC_ITEM]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[UPC_ITEM]
END

GO

