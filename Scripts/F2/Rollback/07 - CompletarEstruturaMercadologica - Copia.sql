
go 
print 'F2 - 07 - CompletarEstruturaMercadologica' 
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompletarEstruturaMercadologica]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[CompletarEstruturaMercadologica]
END
GO

