-- Lote.PesquisaLote

/*
	Declare 
		@Usuario varchar(100) = null --'vn05rzj'
		, @NumeroLote varchar(20) = '20201030160813099'
		, @CodOrigem varchar(5) = '' -- empty todos, Sad, Sams, Novo.
		, @DataDe datetime = null
		, @DataAte datetime = null
		, @StatusLote int = -1 -- 1 = Processado, 0 = Não Processado ou Erro, -1 = todos -- @StatusLote 0 trava @StatusItem em -01
		, @StatusItem varchar(255) = '-01' -- -01 todos, -02 Ok, -03 NOk, xxx - demais (distinct das ultimas msgs)
--*/

Declare @Historico int = 0 -- 1 = Todo o Histórico, 0 = Mais Recente -- Travar como 0, mais recente.

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

Select top 1000
	format(c.IdCarrinho, 'N0', 'pt-br') as IdCarrinho
	, Case 
		When c.CodOrigem = 'Sad' Then 'Manutenção Massiva'
		When c.CodOrigem = 'Novo' Then 'Novos Produtos'
		Else 'Transformação Sams'
	End as TipoCarrinho
	, l.NumeroLote
	, u.[Login]
	, u.Nome
	, ci.item_nbr
	, Case When Isnull(c.CodOrigem, 'Sams') in ('Sad', 'Novo') Then ci.produto_nbr Else x.SAD_CODPRODU End as produto_nbr
	, ISNULL(l.StatusRetorno, 'Lote em processamento.') as StatusLote
	, cil.CodRetorno + ' - ' + cil.StatusRetorno as StatusItem
	, format(l.DhEnvio, 'dd/MM/yy hh:mm:ss') as DhEnvio	
From 
	Lote as l
	Inner Join Carrinho as c on c.IdCarrinho = l.IdCarrinho
	Inner Join CarrinhoItem as ci on ci.IdCarrinho = c.IdCarrinho
	Inner Join TSamsF3User as u on u.[Login] = c.[Login]
	Left Join cteUltimoEnvio as ue on ue.IdCarrinhoItem = ci.IdCarrinhoItem And ue.DhUltimoEnvio = l.DhEnvio
	Left Join CarrinhoItemLote as cil on cil.IdLote = l.IdLote And cil.IdCarrinhoItem = ci.IdCarrinhoItem
	Left Join XREF_BR_IF_ITEM as x on x.IdCarrinhoItem = ci.IdCarrinhoItem
Where
	( Isnull(@Usuario, '') = '' or ( u.[Login] = @Usuario Or u.LoginSad = @Usuario Or u.Nome like '%' + @Usuario + '%' ))
	And ( 
			( Isnull(@NumeroLote, '') = '' )
			Or 
			(
				l.NumeroLote = @NumeroLote 
				And 
				(
					(l.DhRetorno is null And ci.EmEdicao = 1)
					Or
					(l.DhRetorno is not null And cil.IdCarrinhoItemLote is not null )
				)
			)
	)
	And ( isnull(@CodOrigem, '') = '' Or (c.CodOrigem = @CodOrigem) )
	And ( @DataDe is null Or l.DhEnvio >= @DataDe )
	And ( @DataAte is null Or l.DhEnvio <= DATEADD(SECOND, -1, DATEADD(DAY, 1, @DataAte)) )
	And ( @Historico = 1 Or ( ue.IdCarrinhoItem is not null Or cil.IdCarrinhoItemLote is null ))
	And ( 
		( @StatusLote = 1 And l.StatusRetorno = 'Lote processado.' ) 
		Or 
		( @StatusLote = 0 And isnull(l.StatusRetorno, '') <> 'Lote processado.' ) 
		Or 
		( @StatusLote = -1 ) 
	)
	And ( 
		( @StatusItem = '-01' )
		Or
		( @StatusItem = '-02' And cil.CodRetorno = '000' )
		Or
		( @StatusItem = '-03' And cil.CodRetorno <> '000' )
		Or
		( cil.CodRetorno + ' - ' + cil.StatusRetorno = @StatusItem )
	)
Order By
	10 DESC, 4 ASC, ci.IdCarrinhoItem ASC