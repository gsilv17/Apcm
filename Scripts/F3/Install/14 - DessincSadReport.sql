/****** Object:  Table [dbo].[DessincSadReport]    Script Date: 21/01/2021 06:34:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Drop TABLE [dbo].[DessincSadReport]

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DessincSadReport]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DessincSadReport](
	[IdDessincSadReport] [int] IDENTITY(1,1) NOT NULL,
	[NumeroLote] [varchar](20) NOT NULL,
	[IdCarrinhoItem] [int] NOT NULL,
	[DhDessincSadReport] [datetime] NOT NULL,
	[NumeroLoteSadReport] [varchar](20) NULL,
 CONSTRAINT [PK_DessincSadReport] PRIMARY KEY CLUSTERED 
(
	[IdDessincSadReport] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_DessincSadReport_Envio]    Script Date: 21/01/2021 06:34:24 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DessincSadReport]') AND name = N'IX_DessincSadReport_Envio')
CREATE UNIQUE NONCLUSTERED INDEX [IX_DessincSadReport_Envio] ON [dbo].[DessincSadReport]
(
	[NumeroLote] ASC,
	[IdCarrinhoItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO


