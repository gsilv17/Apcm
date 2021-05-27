-- Carrinho.CarrinhosDisponiveis

/*
Declare @Login varchar(10) = 'r0macar', @CodOrigem varchar(5) = 'Sams', @CodSistema varchar(10) = 'Atacado'
--*/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

Select
	c.IdCarrinho as [Key], 
	'#' + format(c.IdCarrinho, 'N0', 'pt-br') 
	+ ' - ' + 
	format(c.DhCriacao, 'dd/MM/yy') 
	+ ' - ' + 
	format(Count(1), 'N0', 'pt-br') + 
		Case 
			When Count(1) = 1 Then 
				Case 
					When c.CodOrigem = 'Sad' Then ' Produto Pendente'
					When c.CodOrigem = 'Novo' Then ' Produto Novo'
					Else ' Item Pendente' 
				End
			Else 
				Case 
					When c.CodOrigem = 'Sad' Then ' Produtos Pendentes' 
					When c.CodOrigem = 'Novo' Then ' Produtos Novos' 
					Else ' Itens Pendentes' 
				End
		End as [Value]
From
	Carrinho as c
	Inner Join CarrinhoItem as ci on ci.IdCarrinho = c.IdCarrinho
Where
	c.[Login] = @Login
	And ci.EmEdicao = 1
	And isnull(ci.Dessinc, 0) = 0
	And ( isnull(@CodOrigem, '') = '' Or c.CodOrigem = @CodOrigem )
	And ( ISNULL(C.CodSistema, 'Atacado') = @CodSistema )
Group By
	c.IdCarrinho, c.DhCriacao, c.CodOrigem
Order By
	c.IdCarrinho Desc
	