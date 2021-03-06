SELECT DISTINCT
	CAR.IDCARRINHO, 
	ISNULL(CAR.Login, '')AS Usuario,
	ISNULL(CARITLT.CODRETORNO,'') AS CodErro,
	CASE WHEN LT.StatusRetorno IS NULL OR LT.StatusRetorno = '' THEN 
		'Não Processado'
	ELSE
		ISNULL(CARITLT.CODRETORNO+' - '+UPPER(CARITLT.STATUSRETORNO), 'Não Processado') 
	END AS StatusRetorno,
	ISNULL(CARITLT.FILIAL,'') AS Filial, 
	ISNULL(CITEM.SAD_CODPRODU, '0') AS CodProdutoSAD,
	ISNULL(CARIT.item_nbr, '0') AS CodItemLink,
	ISNULL(CARIT.item1_desc, '') AS DescricaoItem,	
	ISNULL(CARIT.vendor_nbr, '') AS CodVendor,
	ISNULL(CARIT.DescrVendor, '') AS DescVendor,
	ISNULL(CARIT.codCategoria, '') AS CodigoCategoria,
	ISNULL(CARIT.DescrCategoria, '') AS DescCategoria,
	ISNULL(CARIT.codSubcategoria, '') AS CodigoSubCategoria,
	ISNULL(CARIT.DescrSubCategoria, '') DescSubCategoria
	,CONVERT(VARCHAR(10),ISNULL(LT.DhEnvio, GETDATE()), 103) AS DataEnvio
	,CASE WHEN ISNULL(LT.STATUSRETORNO,'') =  '' THEN 'Não Processado' ELSE 'Processado' END AS StatusRetornoLote
FROM
	CarrinhoItem CARIT
	JOIN CarrinhoItemLote CARITLT
		ON CARIT.IdCarrinhoItem = CARITLT.IdCarrinhoItem
	JOIN LOTE LT
		ON CARITLT.IDLOTE = LT.IDLOTE
	JOIN CARRINHO CAR
		ON LT.IDCARRINHO = CAR.IDCARRINHO
	JOIN TSamsF3User TBUSER
		ON CAR.LOGIN = TBUSER.LOGIN
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
			JOIN CarrinhoItemLote CARITLT
				ON CARIT.IdCarrinhoItem = CARITLT.IdCarrinhoItem
			JOIN LOTE LT
				ON CARITLT.IDLOTE = LT.IDLOTE
			JOIN CARRINHO CAR
				ON LT.IDCARRINHO = CAR.IDCARRINHO
			JOIN TSamsF3User TBUSER
				ON CAR.LOGIN = TBUSER.LOGIN
		WHERE
			CARITLT.CODRETORNO <> '000'
			AND
			(
				(TBUSER.LOGIN = @Login OR TBUSER.LOGINSAD = @Login)
				AND LT.NumeroLote = @Lote
			)
	)DADOS_EXISTENTES
		ON CARITLT.IdCarrinhoItem = DADOS_EXISTENTES.IdCarrinhoItem
WHERE
	CARITLT.CODRETORNO <> '000'
	AND
	(
		(TBUSER.LOGIN = @Login OR TBUSER.LOGINSAD = @Login)
		AND LT.NumeroLote = @Lote
	)
	AND DADOS_EXISTENTES.IdCarrinhoItem IS NOT NULL