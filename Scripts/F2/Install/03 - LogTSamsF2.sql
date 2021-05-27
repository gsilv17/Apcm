

go
print 'F2 - 03 - LogTSamsF2'
go


/****** Object:  Table [dbo].[LogTSamsF2]    Script Date: 13/03/2020 09:48:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogTSamsF2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LogTSamsF2](
	[idLogTSamsF2] [int] IDENTITY(1,1) NOT NULL,
	[idLoad] [int] NOT NULL,
	[nome] [varchar](50) NOT NULL,
	[dhInicio] [datetime] NOT NULL,
	[dhFim] [datetime] NULL,
	[registros] [int] NULL,
	[resultado] [varchar](4000) NULL,
 CONSTRAINT [PK_LogTSamsF2] PRIMARY KEY CLUSTERED 
(
	[idLogTSamsF2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


