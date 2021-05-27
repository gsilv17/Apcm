-- Lote UltimoLote

/*
	Declare @IdCarrinho int = 16
--*/

;with 
cteUltimoEnvio as ( Select IdCarrinho, Max(DhEnvio) as DhUltimoEnvio From Lote Group By IdCarrinho )

Select 
	l.*
From
	cteUltimoEnvio as ur 
	Inner Join Lote as l on l.IdCarrinho = ur.IdCarrinho And l.DhEnvio = ur.DhUltimoEnvio
Where
	l.IdCarrinho = @IdCarrinho
