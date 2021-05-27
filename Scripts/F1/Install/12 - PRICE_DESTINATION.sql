
go
print 'F1 - 12'
go

/****** Object:  Table [dbo].[PRICE_DESTINATION]    Script Date: 24/01/2020 14:30:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRICE_DESTINATION]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PRICE_DESTINATION](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[PRICE_DEST_ID] [int] NULL,
	[PRICE_DEST_TYPE] [int] NULL,
	[HASH_RESULT_NBR] [int] NULL,
	[BU_ID] [int] NULL,
	[STORE_GROUP_ID] [int] NULL,
	[STORE_RULE_ID] [int] NULL,
	[STORE_NBR] [int] NULL,
	[REGION_NBR] [int] NULL,
	[SUBDIV_NBR] [nchar](1) NULL,
	[DC_NBR] [int] NULL,
	[DSS_REQUEST_ID] [int] NULL,
	[STATE_CODE] [nchar](2) NULL
) ON [PRIMARY]
END
GO


