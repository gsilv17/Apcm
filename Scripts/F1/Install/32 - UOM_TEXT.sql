
go
print 'F1 - 32'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UOM_TEXT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UOM_TEXT](
    [rowId] [int] IDENTITY(1,1) NOT NULL,
    [idLoad] [int] NULL,
    [UOM_CODE] [char](2) NULL,
    [LANGUAGE_CODE] [char](3) NULL,
    [UOM_DESCR] [nvarchar](80) NULL) END
GO

