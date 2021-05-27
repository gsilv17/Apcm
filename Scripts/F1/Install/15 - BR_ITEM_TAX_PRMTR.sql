
go
print 'F1 - 15'
go

/****** Object:  Table [dbo].[BR_ITEM_TAX_PRMTR]    Script Date: 24/01/2020 14:49:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BR_ITEM_TAX_PRMTR]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BR_ITEM_TAX_PRMTR](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[ITEM_NBR] [int] NULL,
	[FISCAL_CATEGORY_CODE] [int] NULL,
	[NCM_ID] [int] NULL,
	[SERGIPE_NCM_ID] [int] NULL,
	[FIXED_TAX_QTY] [numeric](9, 4) NULL,
	[PRODEPE_INCTV_NBR] [int] NULL,
	[VNDR_PAY_TAX_IND] [nchar](1) NULL,
	[ICMS_PO_VERIF_IND] [nchar](1) NULL,
	[SIMILAR_ITEM_NBR] [int] NULL,
	[LAST_CHANGE_USERID] [nchar](10) NULL,
	[LAST_CHANGE_TS] [datetime2](7) NULL,
	[REASON_CODE] [int] NULL,
	[TRIB_GRP_CLASF_ID] [int] NULL,
	[STATE_FIXED_TAX_QTY] [numeric](9, 4) NULL,
	[TRIBUTARY_COLLECTION_ID] [int] NULL,
	[TRIB_COLLECTION_ASSN_DATE] [date] NULL
) ON [PRIMARY]
END
GO

