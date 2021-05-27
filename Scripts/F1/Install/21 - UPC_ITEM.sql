
go
print 'F1 - 21'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UPC_ITEM]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UPC_ITEM](
    [RowId] [int] IDENTITY(1,1) NOT NULL,
    [IdLoad] [int] NULL,
    [UPC_NBR] [numeric](15,0) NULL,
    [ITEM_NBR] [int] NULL,
    [LAST_CHANGE_TS] [datetime2] NULL,
    [LAST_CHANGE_USERID] [nchar](10) NULL,
    [LAST_CHANGE_PGM_ID] [nchar](10) NULL,
    [ITEMFILE_SOURCE_NM] [nchar](10) NULL) END

GO



