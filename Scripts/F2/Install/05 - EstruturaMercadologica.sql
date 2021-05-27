
go 
print 'F2 - 05 - EstruturaMercadologica' 
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstruturaMercadologica]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EstruturaMercadologica](
	[CodCategoria] [int] NOT NULL,
	[CodSubcategoria] [int] NOT NULL,
	[CodFineline] [int] NOT NULL,
	[DescrCategoria] [varchar](60) NULL,
	[DescrSubcategoria] [varchar](60) NULL,
	[DescrFineline] [varchar](60) NULL,
 CONSTRAINT [PK_EstruturaMercadologica] PRIMARY KEY CLUSTERED 
(
	[CodCategoria] ASC,
	[CodSubcategoria] ASC,
	[CodFineline] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


