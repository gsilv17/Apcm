
go
print 'F1 - 02'
go

/****** Object:  Table [dbo].[LogTSamsF1]    Script Date: 23/01/2020 09:30:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogTSamsF1]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[LogTSamsF1]
END
GO