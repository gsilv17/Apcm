
go
print 'F1 - 04'
go

/****** Object:  Table [dbo].[CLUB_ITEM]    Script Date: 24/01/2020 09:10:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLUB_ITEM]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CLUB_ITEM](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[CLUB_NBR] [int] NULL,
	[ITEM_NBR] [int] NULL,
	[ITEM_ON_SHELF_DATE] [date] NULL,
	[ITEM_OFF_SHELF_DT] [date] NULL,
	[MARKDOWN_STATUS_CD] [int] NULL,
	[ITEM_STATUS_CODE] [char](1) NULL,
	[UNIT_RETAIL_AMT] [numeric](11, 2) NULL,
	[LINK_ITEM_NBR] [int] NULL,
	[LAST_CHANGE_TS] [datetime2](7) NULL,
	[LAST_CHANGE_USERID] [char](10) NULL,
	[NON_MBR_UPCHRG_IND] [char](1) NULL,
	[UNIT_RETAIL_CHG_DT] [date] NULL,
	[LAST_MARKDOWN_IND] [char](1) NULL,
	[WHPK_SELL_AMT] [numeric](13, 4) NULL,
	[VNPK_COST_AMT] [numeric](13, 4) NULL,
	[LAST_UPDATE_PGM_ID] [char](10) NULL,
	[ITEM_CREATE_DT] [date] NULL,
	[CANCEL_WHN_OUT_DT] [date] NULL,
	[CNCL_UNIT_RTL_AMT] [numeric](11, 2) NULL,
	[LEAD_TIME_QTY] [int] NULL,
	[PROMPT_PRICE_IND] [char](1) NULL,
	[LEASE_SALES_PCT] [numeric](5, 2) NULL,
	[LEASE_EFF_DATE] [date] NULL,
	[LEASE_EXP_DATE] [date] NULL,
	[LAST_SOLD_DATE] [date] NULL,
	[LEASE_DFLT_SLS_PCT] [numeric](5, 2) NULL,
	[ITEMFILE_SOURCE_NM] [char](10) NULL,
	[MAX_RETAIL_AMT] [numeric](11, 2) NULL,
	[WHPK_SELL_CHG_RSN_CD] [int] NULL
) ON [PRIMARY]
END
GO


