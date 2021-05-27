
go
print 'F3 - 03 - Carrinho'
go

/****** Object:  Table [dbo].[Carrinho]    Script Date: 26/10/2020 09:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Carrinho]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Carrinho](
	[IdCarrinho] [int] IDENTITY(1,1) NOT NULL,
	[Login] [varchar](10) NOT NULL,
	[DhCriacao] [datetime] NOT NULL,
	[CodOrigem] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Carrinho] PRIMARY KEY CLUSTERED 
(
	[IdCarrinho] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

