
go 
print 'F2 - 04 - IniciarItemTransformado' 
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IniciarItemTransformado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[IniciarItemTransformado] AS' 
END
GO

ALTER procedure [dbo].[IniciarItemTransformado] (
	@IdLoad int,
	@Registros int output
)

as

Begin

	truncate table ItemTransformado

	Insert Into ItemTransformado (
		  rowId					, idLoad				, item_nbr
		, codCategoria			, codSubcategoria		, codFineline
		, vendor_nbr			, item_type_code		, upc_original
	)
	Select
		  i.rowId				, i.idLoad				, i.item_nbr
		, i.dept_nbr			, i.subclass_nbr		, i.fineline_nbr
		, i.vendor_nbr			, i.item_type_code		, i.UPC_NBR
	From
		item i
	
	Set @registros = @@ROWCOUNT

End
GO

