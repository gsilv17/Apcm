
go
print 'F1 - 10'
go

/****** Object:  Table [dbo].[ITEM_COST_CMPNT]    Script Date: 24/01/2020 14:14:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ITEM_COST_CMPNT]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ITEM_COST_CMPNT]
END
GO


