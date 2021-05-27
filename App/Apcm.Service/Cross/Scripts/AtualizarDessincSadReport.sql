-- Cross.AtualizarDessincSadReport

Declare @tblProdutoDessinc as table (ProdutoNbr int)

Insert Into @tblProdutoDessinc
	Select Distinct
		cd.ProdutoNbr
	From
		CarrinhoDessinc as cd
		Left Join XREF_BR_IF_ITEM_LOG as l
			on l.SAD_CODPRODU = cd.ProdutoNbr
			And isnull(l.DESSINC_ITEM, l.DESSINC_PRODUTO) = 1
	Where
		cd.CodRetorno = '000'
		And l.XREF_BR_IF_ITEM_ID is null

Insert Into @tblProdutoDessinc
	Select Distinct
		SAD_CODPRODU as ProdutoNbr
	From
		XREF_BR_IF_ITEM_LOG as l
	Where
		isnull(l.DESSINC_ITEM, l.DESSINC_PRODUTO) = 1

Declare @UltimoRetornoPositivo as table (ProdutoNbr int, DhRetorno datetime)
Insert Into @UltimoRetornoPositivo
	Select
		ci.produto_nbr as ProdutoNbr, Max(l.DhRetorno) as DhRetorno
	From 
		CarrinhoItem as ci
		Inner Join Carrinho as c
			on ci.IdCarrinho = c.IdCarrinho
		Inner Join Lote as l
			on l.IdCarrinho = c.IdCarrinho
		Inner Join CarrinhoItemLote as cil
			on cil.IdCarrinhoItem = ci.IdCarrinhoItem
			And cil.IdLote = l.IdLote
		Inner Join @tblProdutoDessinc as pd
			on ci.produto_nbr = pd.ProdutoNbr
	Where
		CodRetorno = '000'
		And ISNULL(c.Dessinc, 0) = 0
	Group By
		ci.produto_nbr

Declare @tblDessincSadReport as table (NumeroLote varchar(20), IdCarrinhoItem int, ProdutoNbr int)
Insert Into @tblDessincSadReport
Select
	l.NumeroLote
	, ci.IdCarrinhoItem
	, ur.ProdutoNbr
From 
	@UltimoRetornoPositivo as ur
	Inner Join CarrinhoItem as ci
		on ci.produto_nbr = ur.ProdutoNbr
	Inner Join Carrinho as c
		on ci.IdCarrinho = c.IdCarrinho
	Inner Join Lote as l
		on l.IdCarrinho = c.IdCarrinho
		And l.DhRetorno = ur.DhRetorno

Declare @tblDessincSadReportUnico as table (NumeroLote varchar(20), IdCarrinhoItem int, ProdutoNbr int)
Insert Into @tblDessincSadReportUnico
Select
	NumeroLote, Max(IdCarrinhoItem) as IdCarrinhoItem, ProdutoNbr
From
	@tblDessincSadReport
Group By
	NumeroLote, ProdutoNbr


Insert Into DessincSadReport (
		NumeroLote, IdCarrinhoItem, DhDessincSadReport
	)
	Select
		ru.NumeroLote, ru.IdCarrinhoItem, GETDATE() as DhDessincSadReport
	From 
		@tblDessincSadReportUnico as ru
		Left Join DessincSadReport as dsr
			on dsr.NumeroLote = ru.NumeroLote
			And dsr.IdCarrinhoItem = ru.IdCarrinhoItem
	Where
		dsr.IdDessincSadReport is null