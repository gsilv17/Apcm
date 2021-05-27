
go
print 'F1 - 14'
go

/****** Object:  Table [dbo].[BR_TAX_NCM]    Script Date: 24/01/2020 14:42:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BR_TAX_NCM]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BR_TAX_NCM](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NULL,
	[NCM_ID] [int] NULL,
	[NCM_CODE] [nchar](15) NULL,
	[EX_TIPI_CODE] [nchar](3) NULL,
	[ACTIVE_IND] [nchar](1) NULL,
	[NCM_DESC] [nvarchar](1000) NULL,
	[IPI_TAX_RATE_VAL] [nchar](10) NULL,
	[IPI_LEGAL_MECHANISM] [nchar](70) NULL,
	[LEGAL_TAX_CHG_JSTFN_TXT] [nchar](255) NULL,
	[COMMENT_TXT] [nchar](70) NULL,
	[IPI_EFF_DATE] [date] NULL,
	[IPI_EXPIRE_DATE] [date] NULL,
	[LAST_CHANGE_USERID] [nchar](10) NULL,
	[LAST_CHANGE_TS] [datetime2](7) NULL
) ON [PRIMARY]
END
GO


