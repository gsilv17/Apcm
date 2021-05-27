-- Carrinho ObterCarrinhoItemEnvio

/*
		Declare @IdCarrinho int = 7
--*/

Select
	*
From
	CarrinhoItem as ci
Where
	ci.IdCarrinho = @IdCarrinho
	And ci.EmEdicao = 1
	And Not Exists ( select top 1 1 From CarrinhoItem Where IdCarrinho = @IdCarrinho And DhUltimaImportacaoTemplate is null And EmEdicao = 1 )	