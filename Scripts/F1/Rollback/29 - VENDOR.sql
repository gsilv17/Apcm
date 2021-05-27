
go
print 'F1 - 29'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VENDOR]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[VENDOR]
END
GO


