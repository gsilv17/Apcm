-- Cross.Localizar

/*
	Declare @ProdutoNbr int = 117368
--*/


Select 
	x.XREF_BR_IF_ITEM_ID as IdCross
	, x.SAMS_ITEM_ID as ItemNbr
	, x.SAD_CODPRODU as ProdutoNbr
	, x.IDCARRINHOITEM as IdCarrinhoItem
	, x.ITEM_DESC as ProdutoDesc
	, u.Nome
	, ci.EmEdicao
From
	XREF_BR_IF_ITEM as x
	Inner Join CarrinhoItem as ci
		on ci.IdCarrinhoItem = x.IDCARRINHOITEM
	Inner Join Carrinho as c
		on c.IdCarrinho = ci.IdCarrinho
	Inner Join TSamsF3User as u
		on u.[Login] = c.[Login]
Where
	x.sad_codprodu = @ProdutoNbr
Order By 
	x.SAMS_ITEM_ID Asc

