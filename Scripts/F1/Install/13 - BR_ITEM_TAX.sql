
go
print 'F1 - 13'
go

/****** Object:  Table [dbo].[BR_ITEM_TAX]    Script Date: 24/01/2020 14:36:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BR_ITEM_TAX]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BR_ITEM_TAX](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[ITEM_NBR] [int] NULL,
	[MDSE_ORIGN_CODE] [int] NULL,
	[MDSE_CLASF_CODE] [nchar](15) NULL,
	[XFER_ITEM_NBR] [int] NULL,
	[NATL_ITEM_IND] [nchar](1) NULL,
	[NATL_ITEM_NBR] [numeric](15, 0) NULL,
	[RESTRICTION_IND] [nchar](1) NULL,
	[LAST_CHANGE_TS] [datetime2](7) NULL,
	[LAST_CHANGE_USERID] [nchar](10) NULL,
	[TRANSFER_IND] [nchar](1) NULL,
	[TAX_REFUNDABLE_IND] [nchar](1) NULL,
	[TAX_RPT_ITEM_NBR] [int] NULL,
	[IN_FCTR_MULT_IND] [nchar](1) NULL,
	[IN_ITEM_CNVRS_QTY] [numeric](15, 6) NULL,
	[OUT_FCTR_MULT_IND] [nchar](1) NULL,
	[OUT_ITEM_CNVRS_QTY] [numeric](15, 6) NULL,
	[PRODEPE_INCTV_NBR] [int] NULL,
	[SERGIPE_CLASF_NBR] [nchar](15) NULL,
	[VNDR_PAY_TAX_IND] [nchar](1) NULL,
	[ICMS_PO_VERIF_IND] [nchar](1) NULL,
	[PRODUCT_TYPE_CODE] [int] NULL,
	[BX_ITEM_TYPE_CODE] [int] NULL
) ON [PRIMARY]
END
GO


