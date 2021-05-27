-- Carrinho.AtualizarCarrinho

/*
	Declare @Guid varchar(60), @IdCarrinho int
--*/


Update ci Set
  
  ci.DhUltimaImportacaoTemplate = GETDATE()
, ci.DhUltimaAlteracao = GETDATE()
, ci.ValidacaoTemplate = null
, {0}	

From
	CarrinhoItem as ci
	Inner Join CarrinhoItemBulk as b on
		b.IdCarrinhoItem = ci.IdCarrinhoItem
		And b.IdCarrinho = ci.IdCarrinho
Where
	b.[Guid] = @Guid
	And ci.IdCarrinho = @IdCarrinho	
	And ci.EmEdicao = 1