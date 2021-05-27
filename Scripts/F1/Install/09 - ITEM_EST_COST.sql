
go
print 'F1 - 09'
go

/****** Object:  Table [dbo].[ITEM_EST_COST]    Script Date: 24/01/2020 14:08:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ITEM_EST_COST]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ITEM_EST_COST](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[ITEM_EST_COST_ID] [int] NULL,
	[ITEM_NBR] [int] NULL,
	[PRICE_DEST_ID] [int] NULL,
	[EFFECTIVE_DATE] [date] NULL,
	[EST_LANDED_COST_AMT] [numeric](13, 4) NULL,
	[SALES_TAX_AMT] [numeric](13, 4) NULL,
	[EXPIRATION_DATE] [date] NULL,
	[LAST_UPDATE_TS] [datetime2](7) NULL,
	[LAST_UPDATE_USERID] [nchar](10) NULL,
	[LAST_UPDATE_PGM_ID] [nchar](10) NULL
) ON [PRIMARY]
END
GO


