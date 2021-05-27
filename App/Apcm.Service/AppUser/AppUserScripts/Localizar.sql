Select
	[Login], [LoginSad], [Nome], [Email], [Admin], [Editor], [Atacado], [Varejo]
From
	TSamsF3User as u
Where
	(
		@modoVisualizacao = 0 -- Todos
		Or ( @modoVisualizacao = 1 And u.[Admin] = 0 And u.Editor = 0 ) -- Novos
		Or ( @modoVisualizacao = 2 And u.[Admin] = 1 ) -- Administradores
		Or ( @modoVisualizacao = 3 And u.Editor = 1 ) -- Editores
		Or ( @modoVisualizacao = 4 And u.Atacado = 1 ) -- Atacado
		Or ( @modoVisualizacao = 5 And u.Varejo = 1 ) -- Varejo
	)
	And 
	(
		isnull(@filtro, '') = ''
		Or u.[Login] like '%' + @filtro + '%'
		Or u.[Nome] like '%' + @filtro + '%'
		Or u.[Email] like '%' + @filtro + '%'
		Or u.[LoginSad] like '%' + @filtro + '%'
	)
Order By
	[Login] Asc