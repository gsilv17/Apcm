
go
print 'F1 - 22'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WC_CONS_ALIGN]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WC_CONS_ALIGN](
    [RowId] [int] IDENTITY(1,1) NOT NULL,
    [IdLoad] [int] NULL,
    [WHS_NBR] [int] NULL,
    [ALIGN_TYPE_CODE] [nchar](2) NULL,
    [DIV_NBR] [int] NULL,
    [ALIGN_EFF_DT] [date] NULL,
    [CONS_NBR] [nchar](6) NULL,
    [CONS_SLOT_NBR] [nchar](5) NULL,
    [CONS_CNTL_NBR] [numeric](9,0) NULL,
    [CONS_BU_NBR] [int] NULL) END

GO


