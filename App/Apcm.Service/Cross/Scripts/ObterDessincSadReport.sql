-- Cross.ObterDessincSadReport

Select
	IdDessincSadReport, NumeroLote, IdCarrinhoItem
From
	DessincSadReport
Where
	NumeroLoteSadReport is null