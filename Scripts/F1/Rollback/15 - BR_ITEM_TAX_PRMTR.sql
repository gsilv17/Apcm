
go
print 'F1 - 15'
go

/****** Object:  Table [dbo].[BR_ITEM_TAX_PRMTR]    Script Date: 24/01/2020 14:49:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BR_ITEM_TAX_PRMTR]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[BR_ITEM_TAX_PRMTR]
END
GO


