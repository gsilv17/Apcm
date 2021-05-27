
go 
print 'F2 - 06 - DefinirEstruturaMercadologica' 
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefinirEstruturaMercadologica]') AND type in (N'P', N'PC'))
BEGIN
DROP PROCEDURE [dbo].[DefinirEstruturaMercadologica]
END
GO

