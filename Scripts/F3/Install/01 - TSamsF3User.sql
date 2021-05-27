
go
print 'F3 - 01 - TSamsF3User'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TSamsF3User]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TSamsF3User](
	[Login] [varchar](10) NOT NULL,
	[LoginSad] [varchar](10) NOT NULL,
	[Nome] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[Admin] [bit] NOT NULL,
	[Editor] [bit] NOT NULL,
	[DtUltimoAcesso] [datetime] NULL,
 CONSTRAINT [PK_TSamsF3User] PRIMARY KEY CLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TSamsF3User]') AND name = N'IX_TSamsF3User_LoginSad')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TSamsF3User_LoginSad] ON [dbo].[TSamsF3User]
(
	[LoginSad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




