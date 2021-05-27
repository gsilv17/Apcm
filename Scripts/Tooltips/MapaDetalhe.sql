/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Mapa
	(
	IdMapa int NOT NULL IDENTITY (1, 1),
	EntidadeOrigem varchar(50) NULL,
	CampoOrigem varchar(50) NULL,
	CampoCarrinhoItem varchar(50) NULL,
	NomeColuna varchar(255) NULL,
	Ordem int NULL,
	Grupo varchar(255) NULL,
	Tipo char(1) NOT NULL,
	Tamanho int NULL,
	Precisao int NULL,
	Obrigatorio bit NOT NULL,
	PodeAlterar bit NOT NULL,
	CampoJSon varchar(50) NULL,
	GrupoJSon varchar(50) NULL,
	OrdemJSon int NULL,
	Descricao varchar(1000) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Mapa SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_Mapa ON
GO
IF EXISTS(SELECT * FROM dbo.Mapa)
	 EXEC('INSERT INTO dbo.Tmp_Mapa (IdMapa, EntidadeOrigem, CampoOrigem, CampoCarrinhoItem, NomeColuna, Ordem, Grupo, Tipo, Tamanho, Precisao, Obrigatorio, PodeAlterar, CampoJSon, GrupoJSon, OrdemJSon, Descricao)
		SELECT IdMapa, EntidadeOrigem, CampoOrigem, CampoCarrinhoItem, NomeColuna, Ordem, Grupo, Tipo, Tamanho, Precisao, Obrigatorio, PodeAlterar, CampoJSon, GrupoJSon, OrdemJSon, Descricao FROM dbo.Mapa WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Mapa OFF
GO
DROP TABLE dbo.Mapa
GO
EXECUTE sp_rename N'dbo.Tmp_Mapa', N'Mapa', 'OBJECT' 
GO
ALTER TABLE dbo.Mapa ADD CONSTRAINT
	PK_Mapa PRIMARY KEY CLUSTERED 
	(
	IdMapa
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
