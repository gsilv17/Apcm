
go
print 'F1 - 23'
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SVE_VENDOR_EXPENSE]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[SVE_VENDOR_EXPENSE]
END

GO

