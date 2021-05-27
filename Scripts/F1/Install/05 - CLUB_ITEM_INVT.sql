
go
print 'F1 - 05'
go

/****** Object:  Table [dbo].[CLUB_ITEM_INVT]    Script Date: 24/01/2020 09:28:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLUB_ITEM_INVT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CLUB_ITEM_INVT](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[CLUB_NBR] [int] NULL,
	[ITEM_NBR] [int] NULL,
	[ON_HAND_QTY] [int] NULL,
	[ON_ORDER_QTY] [int] NULL,
	[CLAIM_ON_HAND_QTY] [int] NULL,
	[CNSLD_ON_HAND_QTY] [int] NULL,
	[LAST_RCVD_DATE] [date] NULL,
	[LAST_CHANGE_TS] [datetime2](7) NULL,
	[LAST_CHANGE_USERID] [nchar](10) NULL,
	[LAST_CHANGE_PGM_ID] [nchar](10) NULL,
	[NEG_ON_HAND_DATE] [date] NULL,
	[ITEMFILE_SOURCE_NM] [nchar](10) NULL
) ON [PRIMARY]
END
GO


