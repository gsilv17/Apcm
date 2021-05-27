
go
print 'F1 - 07'
go

/****** Object:  Table [dbo].[SCALABLE_ITEM]    Script Date: 24/01/2020 10:09:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SCALABLE_ITEM]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[SCALABLE_ITEM]
END
GO


