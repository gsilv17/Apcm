
go
print 'F1 - 03'
go

/****** Object:  Table [dbo].[ITEM]    Script Date: 24/01/2020 09:09:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ITEM]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ITEM]
END
GO


