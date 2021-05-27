-- Lote.LotesPendentes

Select
	l.IdLote
	, l.IdCarrinho
	, l.DhEnvio
	, l.NumeroLote
	, l.DhRetorno
	, l.StatusRetorno

	, ISNULL(c.CodSistema, 'Atacado') as CodSistema
	, ISNULL(c.Dessinc, 0) as Dessinc 
From
	Lote as l
	Inner Join Carrinho as c
		on c.IdCarrinho = l.IdCarrinho
Where
	DhRetorno is null
	--l.NumeroLote = '20201215142335818'