
go
print 'F1 - 01'
go

/****** Object:  Table [dbo].[LoadTSams]    Script Date: 23/01/2020 09:09:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadTSams]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoadTSams](
	[IdLoad] [int] IDENTITY(1,1) NOT NULL,
	[DhF1Inicio] [datetime] NULL,
	[DhF1Fim] [datetime] NULL,
	[F1Resultado] [varchar](4000) NULL,
	[DhF2Inicio] [datetime] NULL,
	[DhF2Fim] [datetime] NULL,
	[F2Resultado] [varchar](4000) NULL,
 CONSTRAINT [PK_LoadTSams] PRIMARY KEY CLUSTERED 
(
	[IdLoad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


