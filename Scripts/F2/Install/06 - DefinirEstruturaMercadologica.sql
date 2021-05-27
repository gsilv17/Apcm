
go 
print 'F2 - 06 - DefinirEstruturaMercadologica' 
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DefinirEstruturaMercadologica]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DefinirEstruturaMercadologica] AS' 
END
GO

ALTER procedure [dbo].[DefinirEstruturaMercadologica] (
	@IdLoad int,
	@Registros int output
)

As

Begin

Truncate Table EstruturaMercadologica

Insert Into EstruturaMercadologica (CodCategoria, CodSubcategoria, CodFineline)
Select Distinct 
	DEPT_NBR, SUBCLASS_NBR, FINELINE_NBR 
From 
	ITEM as i

Set @registros = @@ROWCOUNT

Update EstruturaMercadologica Set
	DescrCategoria = rtrim(d.DESCRIPTION_TEXT)
	, DescrSubcategoria = rtrim(s.SUBCLASS_DESC)
	, DescrFineline = rtrim(ISNULL(f.FINELINE_DESC, 'UNKNOWN'))
From
	EstruturaMercadologica as e
	Inner Join DEPARTMENT_DESC as d on e.CodCategoria = d.DEPT_NBR
	Inner Join subclass_text as s on e.CodSubcategoria = s.SUBCLASS_NBR And d.DEPT_NBR = s.DEPT_NBR
	Left Join subclass_fnln_text as f on e.CodFineline = f.FINELINE_NBR And d.DEPT_NBR = f.DEPT_NBR And s.SUBCLASS_NBR = f.SUBCLASS_NBR

End

GO

