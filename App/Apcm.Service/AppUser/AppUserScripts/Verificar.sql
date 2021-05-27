if exists(select top 1 1 from TSamsF3User Where [Login] = @Login)
	Begin
		Update TSamsF3User Set 
			Nome = Case When ISNULL(@Nome, '') = '' Then Nome Else @Nome End,
			Email = Case When ISNULL(@Email, '') = '' Then Email Else @Email End,
			dtUltimoAcesso = GETDATE() 
		Where 
			[Login] = @Login

		Select [Admin], [Editor], [Atacado], [Varejo], [LoginSad] From TSamsF3User Where [Login] = @Login
	End
Else
	Begin
		Select 0 as [Admin], 0 as [Editor], 0 as [Atacado], 0 as [Varejo], '' as [LoginSad] From TSamsF3User
	End