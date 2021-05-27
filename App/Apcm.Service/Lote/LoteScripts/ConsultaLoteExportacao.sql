-- Lote.PesquisaLoteExportacao

/*
	Declare 
		@Usuario varchar(100) = null --'vn05rzj'
		, @NumeroLote varchar(20) = null --'20200909153749257'
		, @CodOrigem varchar(5) = '' -- empty todos, Sad ou Sams.
		, @DataDe datetime = null
		, @DataAte datetime = null
		, @StatusLote int = -1 -- 1 = Processado, 0 = Não Processado ou Erro, -1 = todos -- @StatusLote 0 trava @StatusItem em -01
		, @StatusItem varchar(255) = '-01' -- -01 todos, -02 Ok, -03 NOk, xxx - demais (distinct das ultimas msgs)
		, @StatusItemExport varchar(255) = '-02'
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

Select
	c.IdCarrinho as [Carrinho]
	, Case 
		When c.CodOrigem = 'Sad' Then 'Manutenção Massiva'
		When c.CodOrigem = 'Novo' Then 'Novos Produtos'
		Else 'Transformação Sams'
	End as TipoCarrinho
	, l.NumeroLote as [Lote]
	, u.[Login]
	, u.Nome as [Usuário]
	--, ci.item_nbr as [Cód. Item]
	, Case When Isnull(c.CodOrigem, 'Sams') in ('Sad', 'Novo') Then ci.produto_nbr Else x.SAD_CODPRODU End as [Cód. Produto]

	, ci.item1_desc as [Descrição]
	, ci.Cean as [EAN Produto: Cód. EAN]


	, l.StatusRetorno as [Situação do Lote]
	, cil.CodRetorno + ' - ' + cil.StatusRetorno as [Situação do Item]
	, format(l.DhEnvio, 'dd/MM/yy hh:mm:ss') as [Data e Hora de Envio]

	, ci.vendor_nbr as [Cód. Fornecedor] 
	, ci.descrVendor as [Fornecedor]
	
	--, ci.codCategoria as [Cód. Categoria]
	--, ci.descrCategoria as [Categoria]
	--, ci.codSubcategoria as [Cód. Subcategoria]
	--, ci.descrSubcategoria as [Subcategoria]

	, ci.Secao as [Cód. Seção]
	, ci.DescrSecao as [Seção]
	, ci.Linha as [Cód. Linha]
	, ci.DescrLinha as [Linha]
	, ci.Slinha as [Cód. Sublinha]
	, ci.DescrSublinha as [Sublinha]
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
	And ( @DataAte is null Or l.DhEnvio <= @DataAte )
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
	And (
		( @StatusItemExport = '-01' )
		Or
		( @StatusItemExport = '-02' And cil.CodRetorno = '000' )
		Or
		( @StatusItemExport = '-03' And isnull(cil.CodRetorno, '001') <> '000' )
	)
Order By
	10, 4, ci.IdCarrinhoItem