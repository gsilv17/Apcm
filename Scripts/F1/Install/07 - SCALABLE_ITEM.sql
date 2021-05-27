
go
print 'F1 - 07'
go

/****** Object:  Table [dbo].[SCALABLE_ITEM]    Script Date: 24/01/2020 10:09:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCALABLE_ITEM]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SCALABLE_ITEM](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[PLU_ITEM_NBR] [nchar](5) NULL,
	[COUNTRY_CODE] [nchar](2) NULL,
	[SCALE_ITEM_DESCR1] [nchar](32) NULL,
	[SCALE_ITEM_DESCR2] [nchar](32) NULL,
	[COMMODITY_CLASS_CD] [int] NULL,
	[UPC_TYPE] [nchar](2) NULL,
	[SPECIAL_MESSAGE_CD] [int] NULL,
	[GRAPHICS_NBR] [int] NULL,
	[ACTION_CODE] [nchar](4) NULL,
	[ACTIVE_FOR_SCALES] [nchar](1) NULL,
	[FIXED_WEIGHT_IND] [nchar](1) NULL,
	[LABEL_FORMAT] [nchar](4) NULL,
	[NET_WEIGHT] [int] NULL,
	[PACKAGE_CODE] [nchar](2) NULL,
	[PRICE_MOD_CODE] [nchar](2) NULL,
	[PRODUCT_LIFE] [int] NULL,
	[SHELF_LIFE] [nchar](2) NULL,
	[TARE_WEIGHT] [numeric](5, 3) NULL,
	[LAST_CHG_TIMESTAMP] [datetime2](7) NULL,
	[LAST_CHANGE_USERID] [nchar](8) NULL,
	[CHG_SENT_TIMESTAMP] [datetime2](7) NULL,
	[ORIGIN_CODE] [int] NULL,
	[SEA_AREA_CODE] [int] NULL,
	[RECYCLE_MARK_CD] [int] NULL,
	[STRG_TEMPR_CODE] [int] NULL
) ON [PRIMARY]
END
GO


