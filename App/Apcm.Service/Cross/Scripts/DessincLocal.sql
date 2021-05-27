-- Cross.DessincLocal

/*
	Declare @DessincLocal varchar(max) = '{"Login":"gsilv17","Crosses":[3384]}'
--*/

Declare @Login varchar(10)
Select @Login = Login From
	openjson(@DessincLocal) with (
		Login varchar(10) '$.Login'
	);

Declare @Crosses as table (IdCross int)
Insert Into @Crosses
	Select IdCross From
		openjson(@DessincLocal) with (
			Crosses nvarchar(max) '$.Crosses' as json
		)
		Outer Apply openjson(Crosses) with (
			IdCross int '$'
		);

Declare @DhRetorno datetime
Set @DhRetorno = GETDATE()

Begin Transaction

Begin Try

	-- Armazena log de cross
	Insert Into XREF_BR_IF_ITEM_LOG (
			  XREF_BR_IF_ITEM_ID	, SAMS_ITEM_ID		, SAMS_UPC_NBR		, SAMS_VENDOR_NBR	, SAMS_PLU_NBR
			, SAD_CODPRODU			, SAD_CODIGO_EAN	, IDCARRINHOITEM	, ITEM_DESC			, STATUS_ITEM
			, QTDEPACK				, MULTIPACK			, UPC_REAL			, DT_ALTERACAO		, DIGITO_UPC_REAL
			, TIPO_EAN_SAD			, SAMS_DIGITO_UPC
			, DT_INSERCAO_LOG
			, DESSINC_ITEM			, DESSINC_LOGIN
		)
		Select
			  XREF_BR_IF_ITEM_ID	, SAMS_ITEM_ID		, SAMS_UPC_NBR		, SAMS_VENDOR_NBR	, SAMS_PLU_NBR
			, SAD_CODPRODU			, SAD_CODIGO_EAN	, IDCARRINHOITEM	, ITEM_DESC			, STATUS_ITEM
			, QTDEPACK				, MULTIPACK			, UPC_REAL			, DT_ALTERACAO		, DIGITO_UPC_REAL
			, TIPO_EAN_SAD			, SAMS_DIGITO_UPC
			, @DhRetorno as DT_INSERCAO_LOG
			, 1 as DESSINC_ITEM		, @Login as DESSINC_LOGIN
		From
			XREF_BR_IF_ITEM as x 
			Inner Join @Crosses as c
				on c.IdCross = x.XREF_BR_IF_ITEM_ID
	-- Remove a cross
	Delete From x
		From
			XREF_BR_IF_ITEM as x 
			Inner Join @Crosses as c
				on c.IdCross = x.XREF_BR_IF_ITEM_ID
		
	Commit Transaction

	Select 1 as Ok
End Try
Begin Catch

	Rollback Transaction

	Insert Into ApcmLog (
		Emissor, Tipo, Dh, Mensagem
	) Values (
		'Cross.DessincLocal', 'Erro', @DhRetorno, 'Linha: ' +  CONVERT(varchar, ERROR_LINE()) + ', Erro:' + CONVERT(VARCHAR, ERROR_NUMBER()) + ' - ' + ERROR_MESSAGE()
	)

	Select 0 as Ok
End Catch