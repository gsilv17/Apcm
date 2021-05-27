-- Carrinho - CriarCarrinhoSad

/*
Declare @Login varchar(10), @CodSistema varchar(10)
--*/

Declare 
	@IdCarrinho int,
	@DhCriacao datetime

Set @DhCriacao = GETDATE()

-- Criação do Carrinho
Insert Into Carrinho ( [Login], DhCriacao, CodOrigem, Dessinc, CodSistema ) Values (@Login, @DhCriacao, 'Sad', 0, @CodSistema)
Select @IdCarrinho = @@IDENTITY

-- Retorno do carrinho criado
Select @IdCarrinho as IdCarrinho