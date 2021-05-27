
go
print 'F2 - 01 - Transformacoes'
go

/****** Object:  Table [dbo].[Transformacoes]    Script Date: 13/03/2020 08:46:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Transformacoes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Transformacoes](
	[nome] [varchar](50) NOT NULL,
	[ordemExec] [varchar](30) NOT NULL,
	[detalhes] [varchar](500) NOT NULL,
	[ativa] [bit] NOT NULL,
 CONSTRAINT [PK_Transformacoes] PRIMARY KEY CLUSTERED 
(
	[nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING ON

GO

/****** Object:  Index [IX_Transformacoes]    Script Date: 13/03/2020 08:46:39 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Transformacoes]') AND name = N'IX_Transformacoes')
CREATE UNIQUE NONCLUSTERED INDEX [IX_Transformacoes] ON [dbo].[Transformacoes]
(
	[ordemExec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


