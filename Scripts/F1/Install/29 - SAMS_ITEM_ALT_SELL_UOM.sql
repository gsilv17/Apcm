
go
print 'F1 - 29'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SAMS_ITEM_ALT_SELL_UOM]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SAMS_ITEM_ALT_SELL_UOM](
    [rowId] [int] IDENTITY(1,1) NOT NULL,
    [idLoad] [int] NULL,
    [ITEM_NBR] [int] NULL,
    [ALT_SELL_UOM_CODE] [nchar](2) NULL,
    [ALT_SELL_QTY] [numeric](9,4) NULL,
    [ITEMFILE_SOURCE_NM] [nchar](10) NULL,
    [LAST_UPDATE_PGM_ID] [nchar](10) NULL,
    [LAST_UPDATE_USERID] [nchar](10) NULL,
    [LAST_UPDATE_TS] [datetime2] NULL) END



GO


