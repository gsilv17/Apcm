-- Carrinho - CriarCarrinhoNovo

/*
	Declare @Login varchar(10) = 'gsilv17', @Guid varchar(60) = 'ffdc44aec31749f3ac6a9ae860e0d945', @CodSistema varchar(10) = 'Atacado'
--*/

Declare 
	@IdCarrinho int,
	@DhCriacao datetime,
	@Matric varchar(10),
	@Campos varchar(max),
	@Query nvarchar(max),
	@Parameters nvarchar(max)
	
Set @DhCriacao = GETDATE()
Select @Matric = LoginSad From TSamsF3User Where [Login] = @Login

-- Criação do Carrinho
Insert Into Carrinho ( [Login], DhCriacao, CodOrigem, Dessinc, CodSistema ) Values (@Login, @DhCriacao, 'Novo', 0, @CodSistema)
Select @IdCarrinho = @@IDENTITY

-- Criação de produtos
Update CarrinhoItemBulk Set IdCarrinho = @IdCarrinho Where [Guid] = @Guid
Select @Campos = COALESCE(@Campos + ', ' + m.CampoCarrinhoItem, m.CampoCarrinhoItem) From Mapa as m Where PodeAlterar = 1
Set @Query = N'
Insert Into CarrinhoItem (
		IdCarrinho, DhSelecionado, EmEdicao, DhUltimaImportacaoTemplate
		, ' + @Campos + '
	)
Select 
	@IdCarrinho, @DhCriacao, 1 as EmEdicao, @DhCriacao
	, ' + @Campos + ' 
From 
	CarrinhoItemBulk 
Where 
	[Guid] = @Guid 
	And IdCarrinho = @IdCarrinho
'

Set @Parameters = N'@Guid varchar(60), @IdCarrinho int, @DhCriacao datetime'

Execute sp_executesql @Query, @Parameters, @Guid, @IdCarrinho, @DhCriacao

-- Campos fixos
Update CarrinhoItem Set
	IdLoad = null
	, Matric = @Matric
	, Emplg = '1'
	, TipoProc = 'P'
Where
	IdCarrinho = @IdCarrinho

-- Retorno do carrinho criado
Select @IdCarrinho as IdCarrinho