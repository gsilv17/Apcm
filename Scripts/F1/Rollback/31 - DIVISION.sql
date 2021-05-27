
go
print 'F1 - 31'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIVISION]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[DIVISION]
END
GO

