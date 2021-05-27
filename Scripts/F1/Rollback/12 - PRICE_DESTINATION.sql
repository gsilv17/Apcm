
go
print 'F1 - 12'
go

/****** Object:  Table [dbo].[PRICE_DESTINATION]    Script Date: 24/01/2020 14:30:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PRICE_DESTINATION]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[PRICE_DESTINATION]
END
GO


