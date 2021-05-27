SELECT DISTINCT
	ISNULL(CAR.Login, '')AS Usuario,
	CASE WHEN LT.StatusRetorno IS NULL OR LT.StatusRetorno = '' THEN 
		'Não Processado'
	ELSE
		ISNULL(CARITLT.CODRETORNO+' - '+UPPER(CARITLT.STATUSRETORNO), 'Não Processado') 
	END AS StatusRetorno,
	ISNULL(CITEM.SAD_CODPRODU, '0') AS CodProdutoSAD
	,ISNULL(CARIT.item1_desc, '') AS DescricaoItem
	,ISNULL(CARIT.vendor_nbr, '') AS CodVendor
	,ISNULL(CARIT.DescrVendor, '') AS DescVendor
	,CAST(ISNULL(CARIT.codCategoria, '0') AS INT) AS CodigoCategoria
	,ISNULL(CARIT.DescrCategoria, '') AS DescCategoria
	,CAST(ISNULL(CARIT.codSubcategoria, '0') AS INT) AS CodigoSubCategoria
	,ISNULL(CARIT.DescrSubCategoria, '') DescSubCategoria
	,ISNULL(LT.NumeroLote, '') AS Lote
	,CAST(ISNULL(CARIT.item_nbr, '0') AS INT) AS CodItemLink
	,CONVERT(VARCHAR(10),ISNULL(CARIT.DhSelecionado, GETDATE()), 103) AS DiaHoraSelecionado
	,CAST(ISNULL(CARIT.CodFineLine,'0') AS INT) AS CodFineLine
	,ISNULL(CARIT.cean,'0') AS Upc
	,ISNULL(CARIT.descsinal,'') AS SigningDesc
	,0 AS VnpkQty --ISNULL(CARIT.vnpk_qty,0) AS VnpkQty
	,ISNULL(CARIT.ceaneb,0) AS CaseUpc
	,0 MdseOrignCode--MdseOrignCode--ISNULL(CARIT.mdse_orign_code,0) AS MdseOrignCode  
	,0 MdseClasfCode--MdseClasfCodeISNULL(CARIT.mdse_clasf_code, '') AS MdseClasfCode,
	,0 VendorStockId--ISNULL(CARIT.vendor_stock_id,'') AS VendorStockId,
	,0 VnpkCosAmt--ISNULL(CARIT.vnpk_cost_amt,0) AS VnpkCosAmt,
	,0 ItemLengthQty--ISNULL(CARIT.item_length_qty,0) AS ItemLengthQty,
	,0 ItemWidthQty --ISNULL(CARIT.item_width_qty,0) AS ItemWidthQty,
	,0 ItemHeightQty--ISNULL(CARIT.item_height_qty,0) AS ItemHeightQty,
	,0 MiRrcvngDaysQty--ISNULL(CARIT.min_rcvng_days_qty,0) AS MiRrcvngDaysQty,
	,0 IpiTaxClassCd--ISNULL(CARIT.ipi_tax_class_cd,0) AS IpiTaxClassCd
	,CONVERT(VARCHAR(10),ISNULL(LT.DhEnvio, GETDATE()), 103) AS DataEnvio
	,CASE WHEN ISNULL(LT.STATUSRETORNO,'') =  '' THEN 'Não Processado' ELSE 'Processado' END AS StatusRetornoLote
FROM
	CarrinhoItem CARIT
	JOIN CARRINHO CAR
		ON CARIT.IdCarrinho = CAR.IdCarrinho
	JOIN LOTE LT
		ON carit.idcarrinho = LT.IdCarrinho
	JOIN TSamsF3User TBUSER
		ON CAR.LOGIN = TBUSER.LOGIN
	LEFT JOIN CarrinhoItemLote CARITLT
		ON CARIT.IdCarrinhoItem = CARITLT.IdCarrinhoItem
		and lt.IdLote = CARitlt.IdLote
	LEFT JOIN XREF_BR_IF_ITEM CITEM
		ON CARIT.IdCarrinhoItem = CITEM.IDCARRINHOITEM
		 oR CARIT.item_nbr = CITEM.SAMS_ITEM_ID  
		 or carit.produto_nbr = citem.SAD_CODPRODU
	LEFT JOIN
	(
		SELECT
			CARITLT.IdCarrinhoItem
		FROM
			CarrinhoItem CARIT
			JOIN CARRINHO CAR
				ON CARIT.IdCarrinho = CAR.IdCarrinho
			JOIN LOTE LT
				ON carit.idcarrinho = LT.IdCarrinho
			JOIN TSamsF3User TBUSER
				ON CAR.LOGIN = TBUSER.LOGIN
			JOIN CarrinhoItemLote CARITLT
				ON CARIT.IdCarrinhoItem = CARITLT.IdCarrinhoItem
				and lt.IdLote = CARitlt.IdLote
		WHERE
			LT.NumeroLote = @Lote
			AND CARITLT.CODRETORNO+'|'+UPPER(CARITLT.STATUSRETORNO) = UPPER(@MsgRetorno)
	)DADOS_EXISTENTES
		ON CARITLT.IdCarrinhoItem = DADOS_EXISTENTES.IdCarrinhoItem
WHERE
	LT.NumeroLote = @Lote
	AND CARITLT.CODRETORNO+'|'+UPPER(CARITLT.STATUSRETORNO) = UPPER(@MsgRetorno)
	AND DADOS_EXISTENTES.IdCarrinhoItem IS NOT NULL
	