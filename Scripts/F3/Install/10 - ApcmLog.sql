/****** Object:  Table [dbo].[ApcmLog]    Script Date: 12/10/2020 10:53:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ApcmLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ApcmLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Emissor] [varchar](100) NOT NULL,
	[Tipo] [varchar](10) NOT NULL,
	[Dh] [datetime] NOT NULL,
	[Mensagem] [varchar](4000) NOT NULL,
 CONSTRAINT [PK_ApcmLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_ApcmLog_Emissor]    Script Date: 12/10/2020 10:53:04 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ApcmLog]') AND name = N'IX_ApcmLog_Emissor')
CREATE NONCLUSTERED INDEX [IX_ApcmLog_Emissor] ON [dbo].[ApcmLog]
(
	[Emissor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


