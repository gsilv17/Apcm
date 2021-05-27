
go 
print 'F2 - 04 - IniciarItemTransformado' 
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IniciarItemTransformado]') AND type in (N'P', N'PC'))
BEGIN
DROP PROCEDURE [dbo].[IniciarItemTransformado]
END

GO

