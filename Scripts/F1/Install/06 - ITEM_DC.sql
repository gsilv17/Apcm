
go
print 'F1 - 06'
go

/****** Object:  Table [dbo].[ITEM_DC]    Script Date: 24/01/2020 09:54:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ITEM_DC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ITEM_DC](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[ITEM_NBR] [int] NULL,
	[DC_NBR] [int] NULL,
	[TOT_ON_HAND_QTY] [int] NULL,
	[ON_ORDR_QTY] [int] NULL,
	[RESERVED_QTY] [int] NULL,
	[ALLOCATED_QTY] [int] NULL,
	[LEAD_TIME_QTY] [int] NULL,
	[TEMP_NOT_AVAIL_IND] [nchar](1) NULL,
	[DEFER_BOND_TAX_IND] [nchar](1) NULL,
	[DC_CANCEL_OUT_IND] [nchar](1) NULL,
	[INVENTORY_AMT] [numeric](13, 4) NULL,
	[IMPT_STRG_DC_NBR] [int] NULL,
	[ITEM_STATUS_CODE] [nchar](1) NULL,
	[EST_OUT_OF_STCK_DT] [date] NULL,
	[VNPK_COST_AMT] [numeric](13, 4) NULL,
	[DELIVERED_COST_AMT] [numeric](13, 4) NULL,
	[WHPK_SELL_AMT] [numeric](13, 4) NULL,
	[YTD_VNPK_RCVD_QTY] [int] NULL,
	[YTD_WHPK_SELL_AMT] [numeric](13, 4) NULL,
	[YTD_UNIT_SALES_QTY] [int] NULL,
	[QTD_UNIT_SALES_QTY] [int] NULL,
	[QTD_VNPK_RCVD_QTY] [int] NULL,
	[CROSSREF_PRIME_IND] [nchar](1) NULL,
	[LAST_UPDATE_TS] [datetime2](7) NULL,
	[ITEMFILE_SOURCE_NM] [nchar](10) NULL,
	[VNDR_MIN_ORD_QTY] [int] NULL,
	[VNDR_MINORD_UOM_CD] [nchar](2) NULL,
	[PALLET_TI_QTY] [int] NULL,
	[PALLET_HI_QTY] [int] NULL,
	[VNDR_INCRM_ORD_QTY] [int] NULL,
	[STAPLE_ON_ORD_QTY] [int] NULL,
	[LAST_UPDATE_PGM_ID] [nchar](10) NULL,
	[ITEM_RPLNSHBL_IND] [nchar](1) NULL,
	[INVT_REQUIRED_IND] [nchar](1) NULL,
	[LBL_NOT_INVC_QTY] [int] NULL,
	[CANCEL_WHN_OUT_DT] [date] NULL,
	[OUT_REPL_PRTY_IND] [nchar](1) NULL,
	[DC_FIXED_SLOT_IND] [nchar](1) NULL,
	[LAST_RCVD_DATE] [date] NULL,
	[LAST_UPDATE_USERID] [nchar](10) NULL,
	[WHPK_SELL_CHG_RSN_CD] [int] NULL,
	[TOT_ON_HAND_EACH_QTY] [int] NULL,
	[ON_ORDR_EACH_QTY] [int] NULL,
	[RESERVED_EACH_QTY] [int] NULL,
	[YTD_EACH_RCVD_QTY] [int] NULL,
	[VNDR_MIN_EACH_ORD_QTY] [int] NULL,
	[QTD_EACH_RCVD_QTY] [int] NULL,
	[VNDR_INCRM_EACH_ORD_QTY] [int] NULL,
	[STAPLE_ON_EACH_ORD_QTY] [int] NULL,
	[DLY_OUT_OF_STOCK_CASE_QTY] [int] NULL,
	[WTD_OUT_OF_STOCK_CASE_QTY] [int] NULL,
	[DAILY_SHIP_CASE_QTY] [int] NULL,
	[WTD_SHIP_CASE_QTY] [int] NULL,
	[WTD_DISTR_SHIP_CASE_QTY] [int] NULL,
	[AVG_CASE_WGT_QTY] [numeric](7, 2) NULL,
	[TURN_ONHAND_CASE_QTY] [int] NULL,
	[DISTR_ONHAND_CASE_QTY] [int] NULL,
	[OSS_ONHAND_CASE_QTY] [int] NULL,
	[YTD_RCVD_CASE_QTY] [int] NULL,
	[BUYING_MULTIPLE_QTY] [int] NULL,
	[UNABSORBED_ITEM_COST_AMT] [numeric](9, 2) NULL,
	[SHLF_LIFE_DAYS_QTY] [int] NULL,
	[WHSE_TI_QTY] [int] NULL,
	[WHSE_HI_QTY] [int] NULL,
	[SLOT_ID] [nchar](10) NULL,
	[AVG_DISTRO_COST_AMT] [numeric](13, 4) NULL,
	[AVG_DISTRO_WGT_QTY] [numeric](9, 4) NULL,
	[VNPK_COL_COST_AMT] [numeric](13, 4) NULL,
	[DAILY_DEMAND_QTY] [int] NULL,
	[REPL_MGR_USERID] [nchar](8) NULL,
	[CASE_UPC_NBR] [numeric](15, 0) NULL,
	[MIN_RCVNG_DAYS_QTY] [int] NULL,
	[VENDOR_NBR] [int] NULL,
	[VENDOR_DEPT_NBR] [int] NULL,
	[VENDOR_SEQ_NBR] [int] NULL,
	[VNPK_WEIGHT_QTY] [numeric](11, 4) NULL,
	[VNPK_LENGTH_QTY] [numeric](9, 3) NULL,
	[VNPK_WIDTH_QTY] [numeric](9, 3) NULL,
	[VNPK_HEIGHT_QTY] [numeric](9, 3) NULL,
	[VNPK_CUBE_QTY] [numeric](9, 3) NULL,
	[IMPORT_CASE_LABEL_IND] [nchar](1) NULL,
	[PRSHBL_PARTIAL_ALLOC_IND] [nchar](1) NULL
) ON [PRIMARY]
END
GO


