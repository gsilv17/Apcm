If not exists(Select top 1 1 From TSamsF3User Where [Login] = @loginRede Or [LoginSad] = @loginSad)
Begin
	Insert Into TSamsF3User (
			[Login], [LoginSad], [Admin], [Editor], [Atacado], [Varejo]
		) Values (
			@loginRede, @loginSad, @admin, @editor, @atacado, @varejo
		)
End