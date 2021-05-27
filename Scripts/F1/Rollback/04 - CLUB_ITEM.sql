
go
print 'F1 - '
go

/****** Object:  Table [dbo].[CLUB_ITEM]    Script Date: 24/01/2020 09:10:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLUB_ITEM]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[CLUB_ITEM]
END
GO


