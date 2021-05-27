-- Cross.PesquisaDessinc

/*
	Declare @ProdutoNbr int, @ItemNbr int
--*/

Declare @tblUltimoRetorno as table (ProdutoNbr int, DhRetorno datetime)

Insert into @tblUltimoRetorno
	Select
		cd.ProdutoNbr, Max(DhRetorno) as DhRetorno
	From
		CarrinhoDessinc as cd
	Where
		( @ProdutoNbr is null Or cd.ProdutoNbr = @ProdutoNbr )
	Group By 
		cd.ProdutoNbr

Select 
	cd.ProdutoNbr as ProdutoNbr
	, null as ItemNbr
	, Case
		When cd.CodRetorno = '000' Then 'SAD'
		Else 'Erro (' + cd.MsgRetorno + ')'
	End as TipoDessinc
	, u.Nome as Nome
	, cd.DhRetorno as [Data]
From
	CarrinhoDessinc as cd
	Inner Join @tblUltimoRetorno as ur
		on ur.ProdutoNbr = cd.ProdutoNbr 
		And ur.DhRetorno = cd.DhRetorno
	Left Join XREF_BR_IF_ITEM_LOG as l
		on l.SAD_CODPRODU = cd.ProdutoNbr
		And ( l.DESSINC_ITEM = 1 Or l.DESSINC_PRODUTO = 1 )
	Inner Join Carrinho as c
		on c.IdCarrinho = cd.IdCarrinho
	Inner Join TSamsF3User as u 
		on u.[Login] = c.[Login]
Where
	( @ProdutoNbr is null Or cd.ProdutoNbr = @ProdutoNbr )
	And l.XREF_BR_IF_ITEM_ID is null
	And @ItemNbr is null

UNION

Select 
	l.SAD_CODPRODU as ProdutoNbr
	, l.SAMS_ITEM_ID as ItemNbr
	, Case
		When l.DESSINC_ITEM = 1 Then 'Parcial'
		Else 'Total'
	End as TipoDessinc
	, u.Nome as Nome
	, l.DT_INSERCAO_LOG as [Data]
From 
	XREF_BR_IF_ITEM_LOG as l
	Left Join TSamsF3User as u
		on u.[Login] = l.DESSINC_LOGIN
Where
	( l.DESSINC_ITEM = 1 Or l.DESSINC_PRODUTO = 1 )
	And ( @ProdutoNbr is null Or l.SAD_CODPRODU = @ProdutoNbr )
	And ( @ItemNbr is null Or l.SAMS_ITEM_ID = @ItemNbr )