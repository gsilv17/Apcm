-- Carrinho.RemoverCarrinhoItem

/*
	Declare @IdCarrinhItem int = 16, @Login varchar(10)
--*/

Update CarrinhoItem Set 
	EmEdicao = 0, 
	LoginAlteracaoEmEdicao = Case When @Login = '' Then Null Else @Login End, 
	DhUltimaAlteracao = GETDATE() 
Where 
	IdCarrinhoItem = @IdCarrinhoItem