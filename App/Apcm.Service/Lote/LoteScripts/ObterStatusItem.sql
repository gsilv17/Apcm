-- Lote.ObterStatusItem

/*
	Declare 
		@CodOrigem varchar(10) = ''
		, @DataDe datetime = null
		, @DataAte datetime = null
--*/

Declare @tblStatusItem as Table ([CodStatusItem] varchar(255), [StatusItem] varchar(255))

Insert Into @tblStatusItem Values ('-01', 'Todos'), ('-02', 'Acerto'), ('-03', 'Erro')

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

;with
cteUltimoEnvio as (
	Select 
		cil.IdCarrinhoItem, Max(l.DhEnvio) as DhUltimoEnvio
	From 
		Lote as l
		Inner Join CarrinhoItemLote as cil on cil.IdLote = l.IdLote
	Group By
		cil.IdCarrinhoItem
)

Insert Into @tblStatusItem
Select Distinct
	cil.CodRetorno + ' - ' + cil.StatusRetorno as [CodStatusItem]
	, cil.CodRetorno + ' - ' + cil.StatusRetorno as [StatusItem]
From
	Lote as l
	Inner Join Carrinho as c on c.IdCarrinho = l.IdCarrinho
	Inner Join CarrinhoItem as ci on ci.IdCarrinho = c.IdCarrinho
	Inner Join cteUltimoEnvio as ue on ue.IdCarrinhoItem = ci.IdCarrinhoItem And ue.DhUltimoEnvio = l.DhEnvio
	Inner Join CarrinhoItemLote as cil on cil.IdLote = l.IdLote And cil.IdCarrinhoItem = ci.IdCarrinhoItem
Where
	( @CodOrigem = '' Or c.CodOrigem = @CodOrigem )
	And ( @DataDe is null Or l.DhEnvio >= @DataDe )
	And ( @DataAte is null Or l.DhEnvio <= @DataAte )
Order By 
	1

Select * From @tblStatusItem
