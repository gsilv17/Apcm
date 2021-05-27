
go
print 'F1 - 08'
go

/****** Object:  Table [dbo].[SCALABLE_ITEM_WC]    Script Date: 24/01/2020 12:44:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCALABLE_ITEM_WC]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[SCALABLE_ITEM_WC]
END
GO


