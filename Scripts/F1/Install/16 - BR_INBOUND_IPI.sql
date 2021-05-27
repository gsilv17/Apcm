
go
print 'F1 - 16'
go

/****** Object:  Table [dbo].[BR_INBOUND_IPI]    Script Date: 24/01/2020 14:58:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BR_INBOUND_IPI]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BR_INBOUND_IPI](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[ITEM_NBR] [int] NULL,
	[EFFECTIVE_DATE] [date] NULL,
	[EXPIRE_DATE] [date] NULL,
	[IPI_TRIB_STATUS_CD] [int] NULL,
	[IPI_TAX_CLASS_CD] [int] NULL,
	[IPI_TAX_LEGAL_CD] [int] NULL,
	[FIXED_TAX_AMT] [numeric](13, 6) NULL,
	[TAX_PCT] [numeric](5, 4) NULL,
	[LAST_CHANGE_USERID] [nchar](10) NULL,
	[LAST_CHANGE_TS] [datetime2](7) NULL
) ON [PRIMARY]
END
GO


