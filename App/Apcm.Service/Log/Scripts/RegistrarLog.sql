-- Log.RegistrarLog
Insert Into ApcmLog (Emissor, Tipo, Dh, Mensagem) Values (@Emissor, @Tipo, GETDATE(), @Mensagem)