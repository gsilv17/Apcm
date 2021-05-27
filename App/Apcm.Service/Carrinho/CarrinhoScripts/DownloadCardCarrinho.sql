Select
	  ci.item_nbr as [Código do item SAM'S]
	, ci.item1_desc as [Descrição do item]
	, u.[Login]	as [Login de rede]
	, u.Nome	as [Nome do usuário]
	, u.[LoginSad]	as [Matrícula SAD]
	, c.IdCarrinho	as [Carrinho]
	, ci.ValidacaoTemplate	as [Crítica de validação]
	, ci.DhUltimaImportacaoTemplate as [Data da crítica]
	, ci.vendor_nbr as [Código do Vendor (6 digitos)]
	, ci.codCategoria as [Código da Categoria]
	, ci.descrCategoria as [Descrição da Categoria]
	, ci.codSubcategoria as [Código da Subcategoria]
	, ci.descrSubcategoria as [Descrição da Subcategoria]
From 
	Carrinho as c
	Inner Join CarrinhoItem as ci on ci.IdCarrinho = c.IdCarrinho
	Inner Join TSamsF3User as u on u.[Login] = c.[Login]
Where
	isnull(ci.ValidacaoTemplate, '') <> ''
	And Isnull(c.CodOrigem, 'Sams') = 'Sams'
	And ci.EmEdicao = 1
Order By
	ci.DhUltimaImportacaoTemplate Desc, u.[Login] Asc, ci.item_nbr Asc