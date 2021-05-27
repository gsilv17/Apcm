
go
print 'F1 - 11'
go

/****** Object:  Table [dbo].[PRICING_ACTION]    Script Date: 24/01/2020 14:21:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRICING_ACTION]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[PRICING_ACTION]
END
GO


