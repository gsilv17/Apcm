-- Carrinho ObterContagensCardHome

Declare @QtdSemDexPara int, @QtdComDexPara int, @QtdItens int, @QtdRetornoErroSad int, @QtdRetornoOkSad int, @QtdRetornoSad int, @QtdCarrinhoItens int, @QtdCarrinhoItensErro int
Declare @PercentSemDexPara numeric(5,2), @PercentComDexPara numeric(5,2), @PercentRetornoErroSad numeric(5,2), @PercentCarrinhoItensErro numeric(5,2)

Select -- Contagem de itens na prateleira.
	@QtdItens = Count(1)
From 
	SAD_ITEM_PRATELEIRA as p
	Inner Join ItemTransformado as t on p.item_nbr = t.item_nbr

--Select -- Contagem de itens na prateleira sem Cross
--	@QtdSemDexPara = Count(1)
--From 
--	SAD_ITEM_PRATELEIRA as p
--	Inner Join ItemTransformado as t on p.item_nbr = t.item_nbr
--	Left  Join XREF_BR_IF_ITEM as x on p.item_nbr = x.sams_item_id
--Where
--	x.XREF_BR_IF_ITEM_ID is null

Select -- Contagem de Carrinho Itens Ok + Erro (todos)
	@QtdCarrinhoItens = Count(1)
From
	CarrinhoItem as ci
	Inner Join Carrinho as c on c.IdCarrinho = ci.IdCarrinho
Where
	Isnull(c.CodOrigem, 'Sams') = 'Sams'
	And ci.EmEdicao = 1

Select -- Contagem de Carrinho Itens Erro
	@QtdCarrinhoItensErro = Count(1)
From
	CarrinhoItem as ci
	Inner Join Carrinho as c on c.IdCarrinho = ci.IdCarrinho
Where
	Isnull(c.CodOrigem, 'Sams') = 'Sams'
	And ci.EmEdicao = 1
	And isnull(ci.ValidacaoTemplate, '') <> ''


;with
cteDhUltimoEnvio as ( -- Último envio do lote
	select 
		cil.IdCarrinhoItem,
		MAX(DhEnvio) as DhUltimoEnvio
	From 
		CarrinhoItemLote as cil
		Inner Join Lote as l on l.IdLote = cil.IdLote
	Where
		l.DhEnvio >= '2021-04-13'
	Group By
		cil.IdCarrinhoItem
),
cteUltimoRetorno as ( -- Ultimo Retorno se negativo
	Select
		cil.*
	From
		CarrinhoItemLote as cil
		Inner Join Lote as l 
			on l.IdLote = cil.IdLote
		Inner Join cteDhUltimoEnvio as ur 
			on ur.DhUltimoEnvio = l.DhEnvio 
			And ur.IdCarrinhoItem = cil.IdCarrinhoItem
	Where
		cil.CodRetorno <> '000'
)

Select @QtdRetornoErroSad = Count(1) 
	From
		SAD_ITEM_PRATELEIRA as p
		Inner Join ItemTransformado as t on p.item_nbr = t.item_nbr
		Inner Join CarrinhoItem as ci
			on ci.item_nbr = p.ITEM_NBR
		Inner Join cteUltimoRetorno as ur 
			on ur.IdCarrinhoItem = ci.IdCarrinhoItem
		Inner Join Carrinho as c
			on c.IdCarrinho = ci.IdCarrinho
		Inner Join Lote as l
			on l.IdLote = ur.IdLote
		Inner Join TSamsF3User as u
			on u.[Login] = c.[Login]


;with
cteDhUltimoEnvio as ( -- Último envio do lote
	select 
		cil.IdCarrinhoItem,
		MAX(DhEnvio) as DhUltimoEnvio
	From 
		CarrinhoItemLote as cil
		Inner Join Lote as l on l.IdLote = cil.IdLote
	
	Group By
		cil.IdCarrinhoItem
),
cteUltimoRetorno as ( -- Ultimo Retorno se positivo
	Select
		cil.*
	From
		CarrinhoItemLote as cil
		Inner Join Lote as l 
			on l.IdLote = cil.IdLote
		Inner Join cteDhUltimoEnvio as ur 
			on ur.DhUltimoEnvio = l.DhEnvio 
			And ur.IdCarrinhoItem = cil.IdCarrinhoItem
	Where
		cil.CodRetorno = '000'
)

Select @QtdRetornoOkSad = Count(1) 
	From
		SAD_ITEM_PRATELEIRA as p
		Inner Join ItemTransformado as t on p.item_nbr = t.item_nbr
		Inner Join CarrinhoItem as ci
			on ci.item_nbr = p.ITEM_NBR
		Inner Join cteUltimoRetorno as ur 
			on ur.IdCarrinhoItem = ci.IdCarrinhoItem
		Inner Join Carrinho as c
			on c.IdCarrinho = ci.IdCarrinho
		Inner Join Lote as l
			on l.IdLote = ur.IdLote
		Inner Join TSamsF3User as u
			on u.[Login] = c.[Login]

Select 
	@QtdSemDexPara = isnull(@QtdSemDexPara, 0),
	@QtdComDexPara = isnull(@QtdItens, 0) - isnull(@QtdSemDexPara, 0),
	@QtdItens = isnull(@QtdItens, 0),
	@QtdRetornoErroSad = isnull(@QtdRetornoErroSad, 0),
	@QtdRetornoOkSad = isnull(@QtdRetornoOkSad, 0),
	@QtdCarrinhoItens = isnull(@QtdCarrinhoItens, 0),
	@QtdCarrinhoItensErro = isnull(@QtdCarrinhoItensErro, 0)
	
Set @PercentSemDexPara = Case When @QtdItens = 0 Then .00 Else ROUND((@QtdSemDexPara / convert(decimal, @QtdItens)) * 100, 2) End
Set @PercentComDexPara = Case When @QtdItens = 0 Then .00 Else ROUND((@QtdComDexPara / convert(decimal, @QtdItens)) * 100, 2) End
Set @QtdRetornoSad = @QtdRetornoOkSad + @QtdRetornoErroSad
Set @PercentRetornoErroSad = Case When @QtdRetornoSad = 0 Then .00 Else ROUND((@QtdRetornoErroSad / convert(decimal, @QtdRetornoSad)) * 100, 2) End
Set @PercentCarrinhoItensErro = Case When @QtdCarrinhoItens = 0 Then .00 Else ROUND((@QtdCarrinhoItensErro / convert(decimal, @QtdCarrinhoItens)) * 100, 2) End

Select 
	@QtdSemDexPara as QtdSemDexPara, 
	@QtdComDexPara as QtdComDexPara, 
	@QtdItens as QtdItens,
	@PercentSemDexPara as PercentSemDexPara,
	@PercentComDexPara as PercentComDexPara,
	@QtdRetornoErroSad as QtdRetornoErroSad,
	@QtdRetornoSad as QtdRetornoSad,
	@PercentRetornoErroSad as PercentRetornoErroSad,
	@QtdCarrinhoItens as QtdCarrinhoItens,
	@QtdCarrinhoItensErro as QtdCarrinhoItensErro,
	@PercentCarrinhoItensErro as PercentCarrinhoItensErro
