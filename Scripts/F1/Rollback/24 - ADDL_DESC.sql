
go
print 'F1 - 24'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADDL_DESC]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[ADDL_DESC] 
END

GO


