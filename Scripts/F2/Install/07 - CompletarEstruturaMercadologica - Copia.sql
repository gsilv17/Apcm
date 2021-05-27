
go 
print 'F2 - 07 - CompletarEstruturaMercadologica' 
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompletarEstruturaMercadologica]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CompletarEstruturaMercadologica] AS' 
END
GO

ALTER procedure [dbo].[CompletarEstruturaMercadologica] (
	@IdLoad int,
	@Registros int output
)

As

Begin

Update ItemTransformado Set
	descrCategoria = e.DescrCategoria,
	descrSubcategoria = e.DescrSubcategoria,
	descrFineline = e.DescrFineline
From	
	ItemTransformado as i
	Inner Join EstruturaMercadologica as e on 
		i.codCategoria = e.CodCategoria
		And i.codSubcategoria = e.CodSubcategoria
		And i.codFineline = e.CodFineline
Where
	i.descrCategoria is null or i.descrSubcategoria is null or i.descrFineline is null

Set @registros = @@ROWCOUNT

End

GO

