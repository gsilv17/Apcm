
go
print 'F1 - 18'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SUBCLASS_TEXT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SUBCLASS_TEXT](
    [RowId] [int] IDENTITY(1,1) NOT NULL,
    [IdLoad] [int] NULL,
    [DEPT_NBR] [int] NULL,
    [SUBCLASS_NBR] [int] NULL,
    [LANGUAGE_CODE] [nchar](3) NULL,
    [SUBCLASS_DESC] [nchar](30) NULL,
    [ITEMFILE_SOURCE_NM] [nchar](10) NULL) END
GO

