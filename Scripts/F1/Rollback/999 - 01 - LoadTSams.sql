
go
print 'F1 - 01'
go

/****** Object:  Table [dbo].[LoadTSams]    Script Date: 23/01/2020 09:09:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadTSams]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[LoadTSams]
END
GO


