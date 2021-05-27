
go
print 'F1 - 17'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DEPARTMENT_DESC]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[DEPARTMENT_DESC]

END

GO

