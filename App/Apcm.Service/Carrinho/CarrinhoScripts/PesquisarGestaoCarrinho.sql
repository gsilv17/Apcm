-- Carrinho PesquisaGestaoCarrinho
/*
	Declare @filtro varchar(4000) = '{"Itens":[],"Produtos":[],"Usuario":"gsilv17"}'
--*/

Declare @Itens as table (item bigint)
Declare @Produtos as table (produtoNbr bigint)
Declare @qtdItemUpc int, @qtdProdutos int
Declare @Usuario varchar(100)

Insert Into @Itens
	Select item From
		openjson(@filtro) with (
			itens nvarchar(max) '$.Itens' as json
		)
		Outer Apply openjson(itens) with (
			item bigint '$'
		);
	
Insert Into @Produtos
	Select produtoNbr From
		openjson(@filtro) with (
			produtos nvarchar(max) '$.Produtos' as json
		)
		Outer Apply openjson(produtos) with (
			produtoNbr bigint '$'
		);

Select @Usuario = Usuario From
	openjson(@filtro) with (
		Usuario nvarchar(max) '$.Usuario'
	);

Select @qtdItemUpc = Count(1) From @Itens where item is not null
Select @qtdProdutos = Count(1) From @Produtos where produtoNbr is not null

;with 
	cteCarrinhoItem as (
		Select
			ci.IdCarrinhoItem, ci.item_nbr, ci.produto_nbr, ci.EmEdicao, u.[Login], u.[LoginSad], u.Nome, ci.item1_desc as Descr, ci.Cean, c.CodSistema
		From
			Carrinho as c
			Inner Join CarrinhoItem as ci on c.IdCarrinho = ci.IdCarrinho
			Inner Join TSamsF3User as u on c.[Login] = u.[Login]
		Where
			ci.EmEdicao = 1
			And c.CodOrigem <> 'Novo'
	)
	
Select Distinct
	  ci.IdCarrinhoItem
	, ci.item_nbr
	, ci.produto_nbr
	, ci.[Descr]
	, ci.[Login]
	, ci.[LoginSad]
	, ci.Nome
	, ci.CodSistema
From
	cteCarrinhoItem		as ci
	Left Join @Itens	as itens		on itens.item = ci.item_nbr or itens.item = ci.Cean
	Left Join @Produtos	as produtos		on produtos.produtoNbr = ci.produto_nbr
Where
	(@qtdItemUpc = 0 Or itens.item is not null)
	And (@qtdProdutos = 0 Or produtos.produtoNbr is not null)
	And (@Usuario = '' Or (ci.[Login] = @Usuario Or ci.LoginSad = @Usuario Or ci.Nome like '%' + @Usuario + '%'))