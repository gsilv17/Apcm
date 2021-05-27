-- Cross.ExisteLog

/*
	Declare @ProdutoNbr int = 117368
--*/
Declare @Existe bit

If exists (Select * From XREF_BR_IF_ITEM_LOG as x Where x.sad_codprodu = @ProdutoNbr)
	Set @Existe = 1
Else
	Set @Existe = 0

Select @Existe as existe