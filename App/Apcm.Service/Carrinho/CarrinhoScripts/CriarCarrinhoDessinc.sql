-- Carrinho.CriarCarrinhoDessinc

/*
	Declare @Parametros varchar(max) = '{"Produtos":["1", "2"],"Login":"gsilv17"}'
--*/

Declare @Produtos as table (Produto varchar(50))
Declare @Login varchar(10), @IdCarrinho int

Insert Into @Produtos
	Select Produto From
		openjson(@Parametros) with (
			Produtos nvarchar(max) '$.Produtos' as json
		)
		Outer Apply openjson(Produtos) with (
			Produto varchar(50) '$'
		);

Select @Login = [Login] From
	openjson(@Parametros) with (
		[Login] varchar(10) '$.Login'
	);

-- Criação do carrinho
Insert into Carrinho ([Login], DhCriacao, CodOrigem, Dessinc) Values (@Login, GETDATE(), 'Sad', 1, 'Atacado')
Set @IdCarrinho = @@identity

-- Criação dos itens
Insert Into CarrinhoDessinc (IdCarrinho, ProdutoNbr, DhSelecionado)
Select
	c.IdCarrinho, p.Produto, c.DhCriacao
From
	Carrinho as c
	Cross Join @Produtos as p
Where
	c.IdCarrinho = @IdCarrinho

-- Retorno
Select @IdCarrinho as IdCarrinho