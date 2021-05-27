
go
print 'F1 - 05'
go

/****** Object:  Table [dbo].[CLUB_ITEM_INVT]    Script Date: 24/01/2020 09:28:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLUB_ITEM_INVT]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[CLUB_ITEM_INVT]
END
GO


