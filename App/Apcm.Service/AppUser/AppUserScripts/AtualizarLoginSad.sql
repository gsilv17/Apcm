-- Declare @login varchar(10), @loginSad varchar(10)

If Not Exists ( Select 1 From TSamsF3User where [Login] <> @login And LoginSad = @loginSad )
	Begin
		Update TSamsF3User Set LoginSad = @loginSad Where [Login] = @Login
	End