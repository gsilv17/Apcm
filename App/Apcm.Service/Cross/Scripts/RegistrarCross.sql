-- Cross.RegistrarCross

/*
	Declare @IdCarrinhoItem int = 209384, @CodProd int = 127399, @Cean varchar(20) = '789114910556', @Tean int = 1, @Eandg int = 4
--*/

Declare @CodOrigem varchar(10)

Select @CodOrigem = Isnull(CodOrigem, 'Sams') From Carrinho as c Inner Join CarrinhoItem as ci on ci.IdCarrinho = c.IdCarrinho Where ci.IdCarrinhoItem = @IdCarrinhoItem


if @CodOrigem = 'Sams'
	Begin

		Declare @CodItem int
		Select @CodItem = item_nbr From CarrinhoItem as ci Where ci.IdCarrinhoItem = @IdCarrinhoItem
		
		--if exists ( Select * From XREF_BR_IF_ITEM Where SAD_CODPRODU = @CodProd And SAMS_ITEM_ID = @CodItem ) 
		if exists ( Select * From XREF_BR_IF_ITEM Where SAMS_ITEM_ID = @CodItem ) 
			Begin -- Cross Item Existe 
				Insert Into XREF_BR_IF_ITEM_LOG (	-- Cria Log Sams		
						  XREF_BR_IF_ITEM_ID		, SAMS_ITEM_ID			, SAMS_UPC_NBR		, SAMS_VENDOR_NBR
						, SAMS_PLU_NBR				, SAD_CODPRODU			, SAD_CODIGO_EAN	, IDCARRINHOITEM
						, ITEM_DESC					, STATUS_ITEM			, QTDEPACK			, MULTIPACK
						, UPC_REAL					, DT_ALTERACAO			, DT_INSERCAO_LOG	, DIGITO_UPC_REAL
						, TIPO_EAN_SAD				, SAMS_DIGITO_UPC		
					)
				Select 
						  x.XREF_BR_IF_ITEM_ID		, x.SAMS_ITEM_ID		, x.SAMS_UPC_NBR	, x.SAMS_VENDOR_NBR
						, x.SAMS_PLU_NBR			, x.SAD_CODPRODU		, x.SAD_CODIGO_EAN	, x.IDCARRINHOITEM
						, x.ITEM_DESC				, x.STATUS_ITEM			, x.QTDEPACK		, x.MULTIPACK
						, x.UPC_REAL				, x.DT_ALTERACAO		, GETDATE()			, x.DIGITO_UPC_REAL
						, x.TIPO_EAN_SAD			, x.SAMS_DIGITO_UPC	
				From
					XREF_BR_IF_ITEM as x
					Inner Join CarrinhoItem as ci on ci.produto_nbr = x.SAD_CODPRODU
				Where
					x.SAMS_ITEM_ID = @CodItem
					--x.SAD_CODPRODU = @CodProd
					--And x.SAMS_ITEM_ID = @CodItem

				Update XREF_BR_IF_ITEM Set			-- Atualiza a referencia da Cross
					IDCARRINHOITEM = @IdCarrinhoItem
				From
					XREF_BR_IF_ITEM as x
				Where
					x.SAMS_ITEM_ID = @CodItem
					--x.SAD_CODPRODU = @CodProd
					--And x.SAMS_ITEM_ID = @CodItem

				Update XREF_BR_IF_ITEM Set			-- Atualiza Cross Sams	
					SAMS_ITEM_ID = ci.item_nbr
					, SAMS_UPC_NBR = Case 
						When isnull(ci.Multpk, 'N') = 'S' Then
							Case When isnull(ci.Upcr, '0') = '' Then '0' Else isnull(ci.Upcr, '0') End
						Else
							Case When isnull(ci.upc_original, '0') = '' Then '0' Else isnull(ci.upc_original, '0') End
					End
					, SAMS_VENDOR_NBR = ci.vendor_nbr
					, SAMS_PLU_NBR = 0
					, SAD_CODPRODU = @CodProd
					, SAD_CODIGO_EAN = Case When @Cean = '' Then '0' Else @Cean End
					, ITEM_DESC = ci.item1_desc
					, STATUS_ITEM = ''
					, QTDEPACK = Convert(decimal(10,0), Case When Isnull(ci.Conv, '') = '' Then '0' Else ci.Conv End)
					, MULTIPACK = isnull(ci.Multpk, 'N')
					, UPC_REAL = Case 
						When isnull(ci.Multpk, 'N') = 'S' Then
							Case When isnull(ci.Upcr, '0') = '' Then '0' Else isnull(ci.Upcr, '0') End
						Else
							Case When isnull(ci.upc_original, '0') = '' Then '0' Else isnull(ci.upc_original, '0') End
					End
					, DT_ALTERACAO = GETDATE()
					, DIGITO_UPC_REAL = Case When isnull(ci.Upcrdg, '0') = '' Then '0' Else isnull(ci.Upcrdg, '0') End
					, TIPO_EAN_SAD = @Tean
					, SAMS_DIGITO_UPC = @Eandg
					, IDCARRINHOITEM = @IdCarrinhoItem
				From
					XREF_BR_IF_ITEM as x
					Inner Join CarrinhoItem as ci on x.IDCARRINHOITEM = ci.IdCarrinhoItem
				Where
					x.IDCARRINHOITEM = @IdCarrinhoItem
			End
		Else
			Begin -- Cross Item não existe
				Insert Into XREF_BR_IF_ITEM (		-- Cria a Cross Sams	
						  SAMS_ITEM_ID
						, SAMS_UPC_NBR
						, SAMS_VENDOR_NBR
						, SAMS_PLU_NBR
						, SAD_CODPRODU
						, SAD_CODIGO_EAN
						, IDCARRINHOITEM
						, ITEM_DESC
						, STATUS_ITEM
						, QTDEPACK
						, MULTIPACK
						, UPC_REAL
						, DT_ALTERACAO
						, DIGITO_UPC_REAL
						, TIPO_EAN_SAD
						, SAMS_DIGITO_UPC	
					)
				Select
					ci.item_nbr as SAMS_ITEM_ID
					, Case 
						When isnull(ci.Multpk, 'N') = 'S' Then
							Case When isnull(ci.Upcr, '0') = '' Then '0' Else isnull(ci.Upcr, '0') End
						Else
							Case When isnull(ci.upc_original, '0') = '' Then '0' Else isnull(ci.upc_original, '0') End
					End as SAMS_UPC_NBR
					, ci.vendor_nbr as SAMS_VENDOR_NBR
					, 0 as SAMS_PLU_NBR
					, @CodProd as SAD_CODPRODU
					, Case When @Cean = '' Then '0' Else @Cean End as SAD_CODIGO_EAN
					, ci.IdCarrinhoItem as IDCARRINHOITEM
					, ci.item1_desc as ITEM_DESC
					, '' as STATUS_ITEM
					, Convert(decimal(10,0), Case When Isnull(ci.Conv, '') = '' Then '0' Else ci.Conv End) as QTDEPACK
					, isnull(ci.Multpk, 'N') as MULTIPACK
					, Case 
						When isnull(ci.Multpk, 'N') = 'S' Then
							Case When isnull(ci.Upcr, '0') = '' Then '0' Else isnull(ci.Upcr, '0') End
						Else
							Case When isnull(ci.upc_original, '0') = '' Then '0' Else isnull(ci.upc_original, '0') End
					End as UPC_REAL
					, GETDATE() as DT_ALTERACAO
					, Case When isnull(ci.Upcrdg, '0') = '' Then '0' Else isnull(ci.Upcrdg, '0') End as DIGITO_UPC_REAL
					, @Tean as TIPO_EAN_SAD
					, @Eandg as SAMS_DIGITO_UPC	
				From
					CarrinhoItem as ci
					Left join XREF_BR_IF_ITEM as x on x.IDCARRINHOITEM = ci.IdCarrinhoItem
				Where
					ci.IdCarrinhoItem = @IdCarrinhoItem
					And x.XREF_BR_IF_ITEM_ID is null
			End
	End
Else if @CodOrigem = 'Sad'
	Begin
		Insert Into XREF_BR_IF_ITEM_LOG (			-- Cria Log Sad			
				  XREF_BR_IF_ITEM_ID		, SAMS_ITEM_ID			, SAMS_UPC_NBR		, SAMS_VENDOR_NBR
				, SAMS_PLU_NBR				, SAD_CODPRODU			, SAD_CODIGO_EAN	, IDCARRINHOITEM
				, ITEM_DESC					, STATUS_ITEM			, QTDEPACK			, MULTIPACK
				, UPC_REAL					, DT_ALTERACAO			, DT_INSERCAO_LOG	, DIGITO_UPC_REAL
				, TIPO_EAN_SAD				, SAMS_DIGITO_UPC		
			)
		Select 
					x.XREF_BR_IF_ITEM_ID		, x.SAMS_ITEM_ID		, x.SAMS_UPC_NBR	, x.SAMS_VENDOR_NBR
				, x.SAMS_PLU_NBR			, x.SAD_CODPRODU		, x.SAD_CODIGO_EAN	, x.IDCARRINHOITEM
				, x.ITEM_DESC				, x.STATUS_ITEM			, x.QTDEPACK		, x.MULTIPACK
				, x.UPC_REAL				, x.DT_ALTERACAO		, GETDATE()			, x.DIGITO_UPC_REAL
				, x.TIPO_EAN_SAD			, x.SAMS_DIGITO_UPC	
		From
			XREF_BR_IF_ITEM as x
			Inner Join CarrinhoItem as ci on ci.produto_nbr = x.SAD_CODPRODU
		Where
			ci.IdCarrinhoItem = @IdCarrinhoItem
		
		Update XREF_BR_IF_ITEM Set					-- Atualiza a Cross Sad	
			SAD_CODIGO_EAN		= convert(numeric(18,0), Case When isnumeric(ci.Cean) = 0 Then null Else ci.Cean End)
			, ITEM_DESC			= ci.item1_desc
			, QTDEPACK			= convert(int, round(convert(decimal, Case When isnumeric(ci.Conv) = 0 Then null Else ci.Conv End), 0)) -- OBS.: Perda de precisão!!!!!!!!
			, MULTIPACK			= convert(char(1), SUBSTRING(ci.Multpk, 1, 1))
			, UPC_REAL			= convert(numeric(18,0), Case When isnumeric(ci.Upcr) = 0 Then null Else ci.Upcr End)
			, DIGITO_UPC_REAL	= convert(int, round(convert(decimal, Case When isnumeric(ci.Upcrdg) = 0 Then null Else ci.Upcrdg End), 0))
			, TIPO_EAN_SAD		= convert(int, round(convert(decimal, Case When isnumeric(ci.Tean) = 0 Then null Else ci.Tean End), 0))
			, DT_ALTERACAO		= GETDATE()
			, IDCARRINHOITEM	= ci.IdCarrinhoItem
		From
			XREF_BR_IF_ITEM as x
			Inner Join CarrinhoItem as ci 
				on ci.produto_nbr = x.SAD_CODPRODU
		Where
			ci.IdCarrinhoItem = @IdCarrinhoItem
	End
Else if @CodOrigem = 'Novo'
	Begin
		Update CarrinhoItem Set 
			produto_nbr = @CodProd
			, Cean = @Cean
			, Tean = @Tean
			, Eandg = @Eandg
		Where 
			IdCarrinhoItem = @IdCarrinhoItem
	End

