
;with
cteDhUltimoEnvio as ( 
	select 
		cil.IdCarrinhoItem,
		MAX(DhEnvio) as DhUltimoEnvio
	From 
		CarrinhoItemLote as cil
		Inner Join Lote as l on l.IdLote = cil.IdLote
	Where
		DhEnvio >= '2021-04-13'
	Group By
		cil.IdCarrinhoItem
),
cteUltimoRetorno as (
	Select
		cil.*
	From
		CarrinhoItemLote as cil
		Inner Join Lote as l 
			on l.IdLote = cil.IdLote
		Inner Join cteDhUltimoEnvio as ur 
			on ur.DhUltimoEnvio = l.DhEnvio 
			And ur.IdCarrinhoItem = cil.IdCarrinhoItem
	Where
		cil.CodRetorno <> '000'
)

Select
	c.IdCarrinho			as [Carrinho]
	, Case 
		When c.CodOrigem = 'Sams' Then 
			'Não'
		Else
			'Sim'
	End						as [Manutenção Massiva]
	, p.ITEM_NBR 			as [Código do item SAM'S]
	, p.Descr 				as [Descrição do item]
	, u.[Login]				as [Login de Rede]
	, u.Nome				as [Nome do usuário]
	, u.LoginSad			as [Login SAD]
	, ur.StatusRetorno		as [Mensagem de erro recebida do SAD]
	, l.DhRetorno			as [Data do Retorno SAD]
	, t.vendor_nbr			as [Código do Vendor (6 digitos)]
	, t.descrVendor			as [Descrição do vendor (nome)]
	, t.codCategoria		as [Código da Categoria]
	, t.descrCategoria		as [Descrição da Categoria]
	, t.codSubcategoria		as [Código da Subcategoria]
	, t.descrSubcategoria	as [Descrição da sub categoria]
From
	SAD_ITEM_PRATELEIRA as p
	Inner Join ItemTransformado as t on p.item_nbr = t.item_nbr
	Inner Join CarrinhoItem as ci
		on ci.item_nbr = p.ITEM_NBR
	Inner Join cteUltimoRetorno as ur 
		on ur.IdCarrinhoItem = ci.IdCarrinhoItem
	Inner Join Carrinho as c
		on c.IdCarrinho = ci.IdCarrinho
	Inner Join Lote as l
		on l.IdLote = ur.IdLote
	Inner Join TSamsF3User as u
		on u.[Login] = c.[Login]
Order By
	l.DhRetorno Desc