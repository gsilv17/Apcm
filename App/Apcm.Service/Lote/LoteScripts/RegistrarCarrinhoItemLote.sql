-- Lote.InserirCarrinhoItemLote

/*
	Declare @IdCarrinhoItem int, @NumeroLote varchar(20), @CodRetorno varchar(10), @StatusRetorno varchar(255), @Filial int
--*/

Insert Into CarrinhoItemLote ( IdCarrinhoItem, IdLote, CodRetorno, StatusRetorno, Filial )
	Select
		@IdCarrinhoItem, l.IdLote, @CodRetorno, @StatusRetorno, @Filial
	From
		Lote as l
		Left Join CarrinhoItemLote as cil on cil.IdLote = l.IdLote And cil.IdCarrinhoItem = @IdCarrinhoItem
	Where 
		l.NumeroLote = @NumeroLote
		And cil.IdCarrinhoItemLote is null