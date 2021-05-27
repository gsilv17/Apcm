-- Carrinho.AtualizarValidacaoTemplate

/*
	Declare @Guid varchar(60), @IdCarrinho int
--*/

Update ci Set
	  ci.DhUltimaImportacaoTemplate = GETDATE()
	, ci.DhUltimaAlteracao = GETDATE()
	, ci.ValidacaoTemplate = b.ValidacaoTemplate
From
	CarrinhoItem as ci
	Inner Join CarrinhoItemBulk as b on
		b.IdCarrinhoItem = ci.IdCarrinhoItem
		And b.IdCarrinho = ci.IdCarrinho
Where
	b.[Guid] = @Guid
	And ci.IdCarrinho = @IdCarrinho	
	And ci.EmEdicao = 1