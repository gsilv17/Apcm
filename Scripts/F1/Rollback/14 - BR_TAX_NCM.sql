
go
print 'F1 - 14'
go

/****** Object:  Table [dbo].[BR_TAX_NCM]    Script Date: 24/01/2020 14:42:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BR_TAX_NCM]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[BR_TAX_NCM]
END
GO


