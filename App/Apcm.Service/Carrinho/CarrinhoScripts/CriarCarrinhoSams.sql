-- Carrinho.CriarCarrinho [Obsoleto]

/*
Declare @Login varchar(10), @TipoProc varchar(1), @CodSistema varchar(10)
--*/

Declare 
	@Qtd int,
	@IdCarrinho int,
	@DhCriacao datetime

Set @DhCriacao = GETDATE()

-- Remover relação de itens em edição em outros carrinhos.
if exists (Select * From TSamsF3User Where [Login] = @Login And [Admin] = 1)
Begin
	Update ci Set 
		ci.EmEdicao = 0,
		LoginAlteracaoEmEdicao = @Login,
		DhUltimaAlteracao = GETDATE()
	From
		CarrinhoDataLoad				as cdl
		Inner Join CarrinhoItem			as ci	
			on cdl.item_nbr = ci.item_nbr
		Inner Join Carrinho				as c
			on c.IdCarrinho = ci.IdCarrinho
	Where
		ci.EmEdicao = 1
		And c.CodSistema = @CodSistema
End

Select -- Contagem de Itens para inclusão no carrinho.
	@Qtd = Count(1)
From
	CarrinhoDataLoad as cdl
	Left Join CarrinhoItem as ci on 
		cdl.item_nbr = ci.item_nbr
		And ci.EmEdicao = 1
	Left Join Carrinho as c
		on c.IdCarrinho = ci.IdCarrinho
		And c.CodSistema = @CodSistema
Where
	ci.IdCarrinhoItem is null
	And cdl.[login] = @Login

If ( ISNULL(@Qtd, 0) = 0 )
	Begin -- Não cria carrinho sem itens
		Select 0 as IdCarrinho 
		Return
	End
	
-- Criação do Carrinho
Insert Into Carrinho ( [Login], DhCriacao, CodOrigem, Dessinc, CodSistema ) Values (@Login, @DhCriacao, 'Sams', 0, @CodSistema)
Select @IdCarrinho = @@IDENTITY

-- Inclusão de Itens no Carrinho
Insert Into CarrinhoItem (
		IdCarrinho, IdLoad, DhSelecionado, EmEdicao, 
		item_nbr,
		vendor_nbr, codCategoria, codSubcategoria, codFineline,
		descrVendor, descrCategoria, descrSubcategoria, descrFineline,
		upc_original, Ceantel, Eandgtel,
		Tamp, Unidp, Qtdep, Tref, Uref
	)
Select 
		@IdCarrinho, cdl.idLoad, @DhCriacao, 0,
		cdl.item_nbr,
		it.vendor_nbr, it.codCategoria, it.codSubcategoria, it.codFineline,
		it.descrVendor, it.descrCategoria, it.descrSubcategoria, it.descrFineline,
		it.upc_original,
		SUBSTRING(Convert(varchar, sip.Eantelevenda), 1, LEN(sip.Eantelevenda) -1) as Ceantel,
		RIGHT(sip.Eantelevenda, 1) as Eandgtel,
		Case 
			When sip.Tamp is null Or Isnull(sip.Unidp, '') = '' Or sip.Qtdep is null Or sip.Tref is null Or Isnull(sip.Uref, '') = '' Then
				null
			Else 
				sip.Tamp
		End as Tamp,
		Case 
			When sip.Tamp is null Or Isnull(sip.Unidp, '') = '' Or sip.Qtdep is null Or sip.Tref is null Or Isnull(sip.Uref, '') = '' Then
				null
			Else 
				sip.Unidp
		End as Unidp,
		Case 
			When sip.Tamp is null Or Isnull(sip.Unidp, '') = '' Or sip.Qtdep is null Or sip.Tref is null Or Isnull(sip.Uref, '') = '' Then
				null
			Else 
				sip.Qtdep
		End as Qtdep,
		Case 
			When sip.Tamp is null Or Isnull(sip.Unidp, '') = '' Or sip.Qtdep is null Or sip.Tref is null Or Isnull(sip.Uref, '') = '' Then
				null
			Else 
				sip.Tref
		End as Tref,
		Case 
			When sip.Tamp is null Or Isnull(sip.Unidp, '') = '' Or sip.Qtdep is null Or sip.Tref is null Or Isnull(sip.Uref, '') = '' Then
				null
			Else 
				sip.Uref
		End as Uref
From
	CarrinhoDataLoad				as cdl
	Left Join CarrinhoItem			as ci	
		on cdl.item_nbr = ci.item_nbr
		And ci.EmEdicao = 1
	Inner Join ItemTransformado		as it
		on cdl.item_nbr = it.item_nbr
	Inner Join SAD_ITEM_PRATELEIRA	as sip
		on it.item_nbr = sip.ITEM_NBR
Where
	ci.IdCarrinhoItem is null
	And cdl.[login] = @Login

-- Exclusão DataLoad
Delete From CarrinhoDataLoad Where [login] = @Login

-- Ações sobre a Cross
/* -- Migrado para a exportação do template
Update CarrinhoItem Set
	produto_nbr = x.SAD_CODPRODU
	, Acao = Case When x.SAD_CODPRODU is null Then 'I' Else 'A' End
From	
	CarrinhoItem as ci
	Left Join XREF_BR_IF_ITEM as x
		on x.SAMS_ITEM_ID = ci.item_nbr
Where
	ci.IdCarrinho = @IdCarrinho
*/

-- Preenchimento calculado e dinâmico de dados
Update CarrinhoItem Set

-- Fixos	
  EmEdicao = 1
, TipoProc = @TipoProc
, Emplg = 1
, Matric = u.LoginSad

-- Dinâmicos
, {0}

From
	Carrinho as c
	Inner Join CarrinhoItem as ci
		on c.IdCarrinho = ci.IdCarrinho
	Inner Join ItemTransformado as t
		on ci.item_nbr = t.item_nbr
	Inner Join SAD_ITEM_PRATELEIRA as p
		on ci.item_nbr = p.ITEM_NBR
	Inner Join TSamsF3User as u 
		on u.[Login] = c.[Login]
Where
	c.IdCarrinho = @IdCarrinho

-- Retorno do carrinho criado
Select @IdCarrinho as IdCarrinho