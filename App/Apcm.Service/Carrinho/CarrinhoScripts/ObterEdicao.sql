-- Carrinho - ObterEdicao

/*
	Declare
		@login varchar(10) = 'gsilv17'
--*/

Select 
	*
From
	Carrinho as c
Where
	[login] = @login
	And isnull(Dessinc, 0) = 0