
go
print 'F1 - 17'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DEPARTMENT_DESC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DEPARTMENT_DESC](
    [RowId] [int] IDENTITY(1,1) NOT NULL,
    [IdLoad] [int] NULL,
    [DEPT_NBR] [int] NULL,
    [LANGUAGE_CODE] [nchar](3) NULL,
    [DESCRIPTION_TEXT] [nchar](30) NULL) END
GO

