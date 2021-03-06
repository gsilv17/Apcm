
go
print 'F1 - 10'
go

/****** Object:  Table [dbo].[ITEM_COST_CMPNT]    Script Date: 24/01/2020 14:14:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ITEM_COST_CMPNT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ITEM_COST_CMPNT](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[ITEM_EST_COST_ID] [int] NULL,
	[COST_CMPNT_TYPE_CODE] [int] NULL,
	[COST_COMPONENT_EFF_DATE] [date] NULL,
	[PRICING_ACTION_ID] [int] NULL,
	[COST_COMPONENT_VAL] [numeric](15, 6) NULL,
	[PCT_IND] [nchar](1) NULL,
	[COST_CMPNT_EXPIRATION_DATE] [date] NULL,
	[LAST_UPDATE_TS] [datetime2](7) NULL,
	[LAST_UPDATE_USERID] [nchar](10) NULL,
	[LAST_UPDATE_PGM_ID] [nchar](10) NULL
) ON [PRIMARY]
END
GO


