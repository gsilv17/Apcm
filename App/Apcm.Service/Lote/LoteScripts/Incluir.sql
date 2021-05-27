-- Lote Incluir

/*
	Declare @IdCarrinho int, @NumeroLote varchar(20)
--*/

if not exists ( select * From Lote Where NumeroLote = @NumeroLote )
Begin
	Insert Into Lote (IdCarrinho, DhEnvio, NumeroLote) Values (@IdCarrinho, GETDATE(), @NumeroLote)
End