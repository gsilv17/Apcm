
go
print 'F1 - 02'
go

/****** Object:  Table [dbo].[LogTSamsF1]    Script Date: 23/01/2020 09:30:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogTSamsF1]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LogTSamsF1](
	[IdLog] [int] IDENTITY(1,1) NOT NULL,
	[IdLoad] [int] NOT NULL,
	[Entidade] [varchar](50) NOT NULL,
	[DhInicio] [datetime] NOT NULL,
	[DhFim] [datetime] NULL,
	[Registros] [int] NULL,
	[Resultado] [varchar](4000) NULL,
 CONSTRAINT [PK_LogTSamsF1] PRIMARY KEY CLUSTERED 
(
	[IdLog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO