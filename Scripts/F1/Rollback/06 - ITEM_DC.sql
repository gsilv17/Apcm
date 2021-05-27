
go
print 'F1 - 06'
go

/****** Object:  Table [dbo].[ITEM_DC]    Script Date: 24/01/2020 09:54:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ITEM_DC]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ITEM_DC]
END
GO


