
go
print 'F1 - 24'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ADDL_DESC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ADDL_DESC](
    [rowId] [int] IDENTITY(1,1) NOT NULL,
    [idLoad] [int] NULL,
    [ITEM_SPEED_NBR] [int] NULL,
    [DESC_TYPE_CODE] [int] NULL,
    [LANGUAGE_CODE] [nchar](3) NULL,
    [ADDL_DESC] [nchar](25) NULL,
    [LOCATOR_CODE] [nchar](2) NULL,
    [XMIT_IND] [nchar](1) NULL) END

GO


