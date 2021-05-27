
go
print 'F1 - 09'
go

/****** Object:  Table [dbo].[ITEM_EST_COST]    Script Date: 24/01/2020 14:08:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ITEM_EST_COST]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ITEM_EST_COST]
END
GO


