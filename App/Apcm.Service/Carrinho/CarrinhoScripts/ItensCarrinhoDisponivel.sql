-- Carrinho ItensCarrinhoDisponivel
/*
	Declare
		@IdCarrinho int = 890
--*/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

Select Distinct
	ci.IdCarrinhoItem
	, ci.item_nbr
	, ci.item1_desc
	, codCategoria
	, DescrCategoria
	, codSubcategoria
	, DescrSubCategoria
	, vendor_nbr
	, DescrVendor
	, ci.produto_nbr
	, Case When CodOrigem = 'Sad' Then 'Sad' Else 'Sams' End as CodOrigem
	, ci.Secao
	, ci.Linha
	, ci.Slinha as Sublinha
	, e.N4SAD_SECAO as SecaoDesc
	, e.N5SAD_LINHA as LinhaDesc
	, e.N6SAD_SUBLINHA as SublinhaDesc
From
	Carrinho as c
	Inner Join CarrinhoItem as ci
		on c.IdCarrinho = ci.IdCarrinho
	Left Join IF_HIERARCHY_XREF_SAMS as e
		on e.N4SAD_SECAOID = ci.Secao
		And e.N5SAD_LINHAID = ci.Linha
		And e.N6SAD_SUBLINHAID = ci.Slinha
Where
	c.IdCarrinho = @IdCarrinho
	And ci.EmEdicao = 1
