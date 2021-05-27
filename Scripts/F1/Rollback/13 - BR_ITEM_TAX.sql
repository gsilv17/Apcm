
go
print 'F1 - 13'
go

/****** Object:  Table [dbo].[BR_ITEM_TAX]    Script Date: 24/01/2020 14:36:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BR_ITEM_TAX]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[BR_ITEM_TAX]
END
GO


