-- Carrinho.RemoverCarrinhoItemAutomatico

/*
	Declare @DiasLimiteCarrinho int = 30
--*/

Update CarrinhoItem Set 
	EmEdicao = 0, 
	LoginAlteracaoEmEdicao = null, 
	DhUltimaAlteracao = GETDATE()
From
	Carrinho as c
	Inner Join CarrinhoItem as ci
		on ci.IdCarrinho = c.IdCarrinho
Where 
	ci.EmEdicao = 1
	And c.DhCriacao <= DATEADD(day, @DiasLimiteCarrinho * -1, GETDATE())