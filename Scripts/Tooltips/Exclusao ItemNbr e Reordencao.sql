--Select * from Mapa Order By Ordem --Where NomeColuna like '%EAN Produto: Cód. EAN%'

If Exists (Select * From Mapa Where CampoCarrinhoItem = 'item_nbr')
	Begin
		Delete From Mapa Where Ordem = 2
		Update Mapa Set Ordem = Ordem - 1 Where Ordem >= 3
		Update Mapa Set Ordem = 21 Where CampoCarrinhoItem = ('Comp')
		Update Mapa Set Ordem = 18 Where CampoCarrinhoItem = ('Embc')
		Update Mapa Set Ordem = 19 Where CampoCarrinhoItem = ('Conv')
		Update Mapa Set Ordem = 20 Where CampoCarrinhoItem = ('Embv')
	End
