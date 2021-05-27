
go
print 'F1 - 16'
go

/****** Object:  Table [dbo].[BR_INBOUND_IPI]    Script Date: 24/01/2020 14:58:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BR_INBOUND_IPI]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[BR_INBOUND_IPI]
END
GO


