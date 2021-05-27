
go
print 'F1 - 29'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SAMS_ITEM_ALT_SELL_UOM]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[SAMS_ITEM_ALT_SELL_UOM]
END



GO


