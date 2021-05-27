
-- Último load
Declare @idLoad int
Select @idLoad = Max(idLoad) From loadTSams Where dhF1Fim is not null
if(@idLoad is null) return


Update loadTSams set dhF2Inicio = GETDATE(), dhF2Fim = null, f2Resultado = null where idLoad = @idLoad


Declare @nome varchar(50), @ordemExec varchar(30), @registros int, @resultado varchar(4000)
Declare @idLogTSamsF2 int
Set @resultado = '';
Declare cursorTransformacao Cursor For Select nome, ordemExec From Transformacoes Where ativa = 1 Order By ordemExec asc
Open cursorTransformacao
fetch next from cursorTransformacao into @nome, @ordemExec
While @@FETCH_STATUS = 0
	Begin
		Begin -- Abertura de log
			Set @idLogTSamsF2 = null
			Select @idLogTSamsF2 = idLogTSamsF2 From LogTSamsF2 Where idLoad = @idLoad And nome = @nome
			if @idLogTSamsF2 is null
				Begin
					Insert Into LogTSamsF2 (idLoad, nome, dhInicio)	Values (@idLoad, @nome, GETDATE())	
					Select @idLogTSamsF2 = @@IDENTITY
				End
			Else
				Begin
					Update LogTSamsF2 Set dhInicio = GETDATE(), dhFim = null, registros = null, resultado = null Where idLogTSamsF2 = @idLogTSamsF2
				End
		End

		Begin try -- Execução da transformação
			Exec @nome @idLoad, @registros output
			Update LogTSamsF2 Set dhFim = GETDATE(), registros = @registros, resultado = 'Ok' Where idLogTSamsF2 = @idLogTSamsF2
		End Try
		Begin Catch
			Update LogTSamsF2 Set dhFim = GETDATE(), registros = 0, resultado = ERROR_MESSAGE() Where idLogTSamsF2 = @idLogTSamsF2
			Set @resultado = 'Erro em ' + @nome + ' ('+ @ordemExec +')'
			break
		End Catch
		
		fetch next from cursorTransformacao into @nome, @ordemExec
	End
Close cursorTransformacao
deallocate cursorTransformacao

IF @resultado = ''
	Begin
		Set @resultado = 'Ok'
	End

Update loadTSams set dhF2Fim = GETDATE(), f2Resultado = @resultado where idLoad = @idLoad

GO

