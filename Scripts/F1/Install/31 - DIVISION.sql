
go
print 'F1 - 31'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIVISION]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DIVISION](
    [rowId] [int] IDENTITY(1,1) NOT NULL,
    [idLoad] [int] NULL,
    [DIV_NBR] [int] NULL,
    [DIV_NAME] [char](30) NULL,
    [MANAGER_NAME] [char](30) NULL,
    [DIV_TYPE_CODE] [int] NULL) END
GO

