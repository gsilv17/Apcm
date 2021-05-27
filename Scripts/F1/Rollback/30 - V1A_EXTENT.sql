
go
print 'F1 - 31'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V1A_EXTENT]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[V1A_EXTENT]
END

GO

