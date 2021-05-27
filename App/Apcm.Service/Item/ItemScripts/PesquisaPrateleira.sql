/*
	Declare @filtro varchar(4000) = '{"Itens":[],"Fornecedores":[],"Estrutura":[{"CodCategoria":-1,"CodSubcategoria":-1,"CodFineline":-1}],"PossuiCross":-1,"EmEdicao":-1}'
--*/

Declare @Itens as table (item bigint)
Declare @Fornecedores as table (vendor int)
Declare @Estrutura as table (CodCategoria int, CodSubcategoria int, CodFineline int)
Declare	@PossuiCross int, @EmEdicao int
Declare @qtdItemUpc int, @qtdFornecedor int, @qtdEstrutura int

Insert Into @Itens
	Select item From
		openjson(@filtro) with (
			Itens nvarchar(max) '$.Itens' as json
		)
		Outer Apply openjson(Itens) with (
			item bigint '$'
		);

Insert Into @Fornecedores
	Select vendor From
		openjson(@filtro) with (
			Fornecedores nvarchar(max) '$.Fornecedores' as json
		)
		Outer Apply openjson(Fornecedores) with (
			vendor int '$'
		);

Insert Into @Estrutura
	Select CodCategoria, CodSubcategoria, CodFineline From
		openjson(@filtro) with (	
			Estrutura nvarchar(max) '$.Estrutura' as json
		)
		Outer Apply openjson(Estrutura) with (
			CodCategoria int '$.CodCategoria', 
			CodSubcategoria int '$.CodSubcategoria', 
			CodFineline int '$.CodFineline'
		);

Select @PossuiCross = PossuiCross, @EmEdicao = EmEdicao From
	openjson(@filtro) with (
		PossuiCross int '$.PossuiCross',
		EmEdicao int '$.EmEdicao'
	);

Select @qtdItemUpc = Count(1) From @Itens where item is not null
Select @qtdFornecedor = Count(1) From @Fornecedores where vendor is not null
Select @qtdEstrutura = Count(1) From @Estrutura Where CodCategoria is not null

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

;with 
	cteEmEdicao as (
		Select
			ci.item_nbr, u.[Login], ci.EmEdicao, u.Nome
		From
			Carrinho as c
			Inner Join CarrinhoItem as ci on c.IdCarrinho = ci.IdCarrinho
			Inner Join TSamsF3User as u on c.[Login] = u.[Login]
		Where
			ci.EmEdicao = 1
	)
	
Select Distinct Top 1000
	  i.idLoad
	, i.item_nbr
	, [ip].Descr as item1_desc
	, [ip].Cean as upc_nbr
	, i.vendor_nbr
	, i.codCategoria
	, i.descrCategoria
	, i.codSubcategoria
	, i.descrSubcategoria
	, i.codFineline
	, i.descrFineline
	, ISNULL(e.EmEdicao, 0)	as EmEdicao
	, e.[Login]
	, e.Nome
	
From
	ItemTransformado				as i
	Inner Join SAD_ITEM_PRATELEIRA	as [ip]			on i.ITEM_NBR = [ip].ITEM_NBR
	Left Join @Itens				as itens		on i.ITEM_NBR = itens.item or [ip].Cean = itens.item or Case When [i].upc_original = '' Then '0' Else [i].upc_original End = itens.item
	Left Join @Fornecedores			as fornecedores	on i.vendor_nbr = fornecedores.vendor
	Left Join cteEmEdicao			as e			on i.ITEM_NBR = e.item_nbr
	Left Join XREF_BR_IF_ITEM		as xItem		on xItem.SAMS_ITEM_ID = isnull(itens.item, i.item_nbr)
	Left Join XREF_BR_IF_ITEM		as xUpc			on xUpc.SAMS_UPC_NBR = itens.item
	Left Join @Estrutura			as est			on 
		( est.CodCategoria = -1 Or est.CodCategoria = i.codCategoria )
		And ( est.CodSubcategoria = -1 Or est.CodSubcategoria = i.codSubcategoria )
		And ( est.CodFineline = -1 Or est.CodFineline = i.codFineline )
Where
	( @qtdEstrutura = 0 Or est.CodCategoria is not null )
	And (@qtdItemUpc = 0 Or itens.item is not null)
	And (@qtdFornecedor = 0 Or fornecedores.vendor is not null)
	And (
		@PossuiCross = -1
		Or
		(
			(@PossuiCross = 1 And isnull(xItem.XREF_BR_IF_ITEM_ID, xUpc.XREF_BR_IF_ITEM_ID) is not null)
			Or
			(@PossuiCross = 0 And isnull(xItem.XREF_BR_IF_ITEM_ID, xUpc.XREF_BR_IF_ITEM_ID) is null)
		)
	)
	And (
		@EmEdicao = -1
		Or 
		ISNULL(e.EmEdicao, 0) = @EmEdicao
	)