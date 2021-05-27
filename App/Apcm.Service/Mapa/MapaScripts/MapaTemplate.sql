Select
	CampoCarrinhoItem, NomeColuna, Ordem, 
	Grupo, Tipo, Tamanho, 
	Precisao, Obrigatorio, PodeAlterar, Descricao
From
	Mapa
Where
	Ordem is not null
Order By
	Ordem Asc