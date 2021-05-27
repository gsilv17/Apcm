-- Carrinho.ObterExportacao

/*
	Declare @IdCarrinho int = 696
--*/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

Declare @CodOrigem varchar(5)

Select @CodOrigem = CodOrigem From Carrinho Where IdCarrinho = @IdCarrinho

/*
IF @CodOrigem = 'Sams' -- Ações sobre a Cross
	Begin

	Update CarrinhoItem Set -- Regra 2 - Possui cross item ou possui cross upc sem multipack.					
		produto_nbr =
			Case 
				When xItem.XREF_BR_IF_ITEM_ID is not null Or xUpc.MULTIPACK = 'N' Or xUpc.MULTIPACK = '' Then
					isnull(xItem.SAD_CODPRODU, xUpc.SAD_CODPRODU)
				Else 
					null
			End
	From	
		CarrinhoItem as ci
		Inner Join ITEM as i on i.ITEM_NBR = ci.item_nbr
		Left Join XREF_BR_IF_ITEM as xItem on xItem.SAMS_ITEM_ID = ci.item_nbr
		Left Join XREF_BR_IF_ITEM as xUpc on convert(varchar, xUpc.SAMS_UPC_NBR) = ci.upc_original
	Where
		ci.IdCarrinho = @IdCarrinho
		And ci.EmEdicao = 1

	Update CarrinhoItem Set -- Regra 2 - Possui cross upc, multipack, mesmo pack.								
		produto_nbr = xUpc.SAD_CODPRODU
	From	
		CarrinhoItem as ci
		Inner Join XREF_BR_IF_ITEM as xUpc on 
			convert(varchar, xUpc.SAMS_UPC_NBR) = ci.upc_original 
			And convert(int, convert(decimal(6,2), ci.conv)) = xUpc.QTDEPACK
	Where
		ci.IdCarrinho = @IdCarrinho
		And ci.EmEdicao = 1
		And xUpc.MULTIPACK = 'S'
		And ci.produto_nbr is null

	Update CarrinhoItem Set -- Regra 2 - Define ação, depende do produto_nbr.									
		Acao = Case When produto_nbr is null then 'I' Else 'A' End
	From	
		CarrinhoItem as ci
	Where
		ci.IdCarrinho = @IdCarrinho
		And ci.EmEdicao = 1

	Update CarrinhoItem Set -- Regra 27 - Possui cross e é multipack											
		Multpk =
			Case
				When xItem.MULTIPACK = 'S' Or xUpc.MULTIPACK = 'S' Then
					'S'
				Else
					null
			End
	From	
		CarrinhoItem as ci
		Inner Join ITEM as i on i.ITEM_NBR = ci.item_nbr
		Left Join XREF_BR_IF_ITEM as xItem on xItem.SAMS_ITEM_ID = ci.item_nbr
		Left Join XREF_BR_IF_ITEM as xUpc on convert(varchar, xUpc.SAMS_UPC_NBR) = ci.upc_original
	Where
		ci.IdCarrinho = @IdCarrinho
		And ci.EmEdicao = 1

	Update CarrinhoItem Set -- Regra 28~29 - Possui cross item, multipack.										
		Upcr = xItem.UPC_REAL
		, Upcrdg = xItem.DIGITO_UPC_REAL
		, Cean = xItem.SAD_CODIGO_EAN
		, Eandg = xItem.SAMS_DIGITO_UPC
		, Tean = xItem.TIPO_EAN_SAD 
	From	
		CarrinhoItem as ci
		Inner Join ITEM as i on i.ITEM_NBR = ci.item_nbr
		Inner Join XREF_BR_IF_ITEM as xItem on xItem.SAMS_ITEM_ID = ci.item_nbr
	Where
		ci.IdCarrinho = @IdCarrinho
		And ci.EmEdicao = 1
		And xItem.MULTIPACK = 'S'

	Update CarrinhoItem Set -- Regra 28~29 - Sem cross item, com cross upc, multipack, pack diferente.			
		Upcr = xItem.UPC_REAL
		, Upcrdg = xItem.DIGITO_UPC_REAL
		, Cean = null
		, Eandg = null
		, Tean = 3
	From	
		CarrinhoItem as ci
		Inner Join ITEM as i on i.ITEM_NBR = ci.item_nbr
		Left Join XREF_BR_IF_ITEM as xItem on xItem.SAMS_ITEM_ID = ci.item_nbr
		Inner Join XREF_BR_IF_ITEM as xUpc on 
			convert(varchar, xUpc.SAMS_UPC_NBR) = ci.upc_original
			And convert(int, convert(decimal(6,2), ci.conv)) <> xUpc.QTDEPACK
	Where
		ci.IdCarrinho = @IdCarrinho
		And ci.EmEdicao = 1
		And xItem.XREF_BR_IF_ITEM_ID is null
		And xItem.MULTIPACK = 'S'

	Update CarrinhoItem Set -- Regra 28~29 - Sem cross item, com cross upc, multipack, mesmo pack.				
		Upcr = xUpc.UPC_REAL
		, Upcrdg = xUpc.DIGITO_UPC_REAL
		, Cean = xUpc.SAD_CODIGO_EAN
		, Eandg = xUpc.SAMS_DIGITO_UPC
		, Tean = xUpc.TIPO_EAN_SAD 
	From	
		CarrinhoItem as ci
		Inner Join ITEM as i on i.ITEM_NBR = ci.item_nbr
		Left Join XREF_BR_IF_ITEM as xItem on xItem.SAMS_ITEM_ID = ci.item_nbr
		Inner Join XREF_BR_IF_ITEM as xUpc on 
			convert(varchar, xUpc.SAMS_UPC_NBR) = ci.upc_original
			And convert(int, convert(decimal(6,2), ci.conv)) = xUpc.QTDEPACK
	Where
		ci.IdCarrinho = @IdCarrinho
		And ci.EmEdicao = 1
		And xItem.XREF_BR_IF_ITEM_ID is null
		And xItem.MULTIPACK = 'S'
		
	Update CarrinhoItem Set -- Regra 44 - Diversas ações, detalhes abaixo.										
		Edi = 
			Case
				When i.PLU_NBR is not null Then							-- Possui PLU.
					'N'
				Else													-- Não possui PLU
					'S'
			End
	From	
		CarrinhoItem as ci
		Inner Join ITEM as i on i.ITEM_NBR = ci.item_nbr
	Where
		ci.IdCarrinho = @IdCarrinho
		And ci.EmEdicao = 1

	Update CarrinhoItem Set -- Regra 44 - Não possui PLU, com outro item de mesmo UPC com case upc diferente.
		Edi = 'G'
		, Ceaneb = null
		, Teaneb = null
	From	
		CarrinhoItem as ci
		Inner Join ITEM as i on i.ITEM_NBR = ci.item_nbr
		Inner Join item as ix on 
				ix.item_nbr		<> i.item_nbr 
			And ix.upc_nbr		=  i.upc_nbr 
			And ix.CASE_UPC_NBR <> i.CASE_UPC_NBR
		Inner Join SAD_ITEM_PRATELEIRA as p on
			p.ITEM_NBR = ix.ITEM_NBR
	Where
		ci.IdCarrinho = @IdCarrinho
		And i.PLU_NBR is null
		And ci.EmEdicao = 1

	End
*/
-- Critica SAD e data de última exportação

Begin
	;With
	cteUltimoEnvio as ( Select IdCarrinho, Max(DhEnvio) as DhEnvio From Lote Where IdCarrinho = @IdCarrinho Group By IdCarrinho ), 
	cteUltimoLote as ( Select l.* From Lote as l Inner Join cteUltimoEnvio as u on u.IdCarrinho = l.IdCarrinho And u.DhEnvio = l.DhEnvio ),
	cteUltimaCritica as ( Select cil.IdCarrinhoItem, cil.CodRetorno + ' - ' + cil.StatusRetorno as CriticaSAD From cteUltimoLote as l inner join CarrinhoItemLote as cil on cil.IdLote  = l.IdLote )

	update CarrinhoItem Set
		CriticaSAD = uc.CriticaSAD
		, DhUltimaExportacaoTemplate = GETDATE()
	From
		CarrinhoItem as ci
		Left Join cteUltimaCritica as uc on uc.IdCarrinhoItem = ci.IdCarrinhoItem
	Where
		ci.IdCarrinho = @IdCarrinho
		And ci.EmEdicao = 1
End

Select * From Carrinho Where IdCarrinho = @IdCarrinho

Select

{0}

From
	CarrinhoItem
Where
	IdCarrinho = @IdCarrinho
	And EmEdicao = 1
