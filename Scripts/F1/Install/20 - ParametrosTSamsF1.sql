
go
print 'F1 - 20'
go

/****** Object:  Table [dbo].[ParametrosTSamsF1]    Script Date: 19/05/2020 12:42:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ParametrosTSamsF1]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ParametrosTSamsF1](
	[Nome] [varchar](30) NOT NULL,
	[Valor] [varchar](4000) NOT NULL,
 CONSTRAINT [PK_ParametrosTSamsF1] PRIMARY KEY CLUSTERED 
(
	[Nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS ( Select * From ParametrosTSamsF1 Where Nome = 'LoadInicial' )
	Begin
		Insert Into [ParametrosTSamsF1] Values ('LoadInicial', 'S')
	End

GO

