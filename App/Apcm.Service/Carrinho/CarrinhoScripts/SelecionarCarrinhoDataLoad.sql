/*
Declare 
	@login varchar(10) = 'gsilv17'
--*/

Delete From CarrinhoDataLoad Where [Login] = @login
Select * From CarrinhoDataLoad Where [Login] = @login