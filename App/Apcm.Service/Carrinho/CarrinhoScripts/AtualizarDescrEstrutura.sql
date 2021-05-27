-- Carrinho AtualizarDescrEstrutura

/*
	Declare @IdCarrinho int = 15
--*/

Declare 
	@Table varchar(max),
	@Query nvarchar(max),
	@Parameters nvarchar(max),
	@CodSistema varchar(10)

Select @CodSistema = Isnull(CodSistema, 'Atacado') From Carrinho Where IdCarrinho = @IdCarrinho
Select @Table = Case When @CodSistema = 'Atacado' Then 'IF_HIERARCHY_XREF_SAMS' Else 'IF_HIERARCHY_XREF' End
Set @Parameters = N'@IdCarrinho int'

Set @Query = N'
Update CarrinhoItem Set
	  SamsCodDepartamento = x.N3WM_DEPTOID
	, SamsDescrDepartamento = x.N3WM_DEPTO
	, DescrSecao = x.N4SAD_SECAO
	, DescrLinha = x.N5SAD_LINHA 
	, DescrSublinha = x.N6SAD_SUBLINHA
From
	CarrinhoItem as ci
	Inner Join SAD_ITEM_PRATELEIRA as p on p.item_nbr = ci.item_nbr
	Left  Join ' + @Table + ' as x on 
		x.N4SAD_SECAOID = p.Secao
		And x.N5SAD_LINHAID = p.Linha
		And x.N6SAD_SUBLINHAID = p.Slinha
Where
	ci.IdCarrinho = @IdCarrinho
'

Execute sp_executesql @Query, @Parameters, @IdCarrinho


