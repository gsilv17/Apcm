-- Lote.RegistrarCarrinhoDessinc

/*
	Declare @DessincRetorno varchar(max) = '{"NumeroLote":"20201126163600000","Produtos":[{"ProdutoNbr": "1", "CodRetorno":"000", "MsgRetorno":"Ok"}, {"ProdutoNbr": "2", "CodRetorno":"001", "MsgRetorno":"Erro"}]}'
--*/

Declare @NumeroLote varchar(20)
Select @NumeroLote = NumeroLote From
	openjson(@DessincRetorno) with (
		NumeroLote varchar(20) '$.NumeroLote'
	);

Declare @Produtos as table (ProdutoNbr varchar(50), CodRetorno varchar(10), MsgRetorno varchar(255))
Insert Into @Produtos
	Select ProdutoNbr, CodRetorno, MsgRetorno From
		openjson(@DessincRetorno) with (
			Produtos nvarchar(max) '$.Produtos' as json
		)
		Outer Apply openjson(Produtos) with (
			ProdutoNbr varchar(50) '$.ProdutoNbr',
			CodRetorno varchar(10) '$.CodRetorno',
			MsgRetorno varchar(255) '$.MsgRetorno'
		);

Declare @DhRetorno datetime
Set @DhRetorno = GETDATE()

Declare @Login varchar(10)

Begin Transaction

Begin Try

	Select
		@Login = c.[Login]
	From
		Lote as l 
		Inner Join Carrinho as c
			on c.IdCarrinho = l.IdCarrinho
	Where
		l.NumeroLote = @NumeroLote
			
	-- Registra o retorno
	Update cd Set
		DhRetorno = @DhRetorno,
		CodRetorno = p.CodRetorno,
		MsgRetorno = p.MsgRetorno
	From
		CarrinhoDessinc as cd
		Inner Join Carrinho as c
			on c.IdCarrinho = cd.IdCarrinho
		Inner Join Lote as l 
			on l.IdCarrinho = c.IdCarrinho
		Inner Join @Produtos as p
			on p.ProdutoNbr = cd.ProdutoNbr
	Where
		l.NumeroLote = @NumeroLote

	-- Remove os carrinhos de edição
	Update ci Set
		EmEdicao = 0
		, LoginAlteracaoEmEdicao = null
		, Dessinc = 1
		, DhUltimaAlteracao = @DhRetorno
	From 
		CarrinhoItem as ci
		Inner Join @Produtos as p
			on p.ProdutoNbr = ci.produto_nbr
	Where 
		ci.EmEdicao = 1
		And p.CodRetorno = '000'

	-- Armazena log de cross
	Insert Into XREF_BR_IF_ITEM_LOG (
			  XREF_BR_IF_ITEM_ID	, SAMS_ITEM_ID		, SAMS_UPC_NBR		, SAMS_VENDOR_NBR	, SAMS_PLU_NBR
			, SAD_CODPRODU			, SAD_CODIGO_EAN	, IDCARRINHOITEM	, ITEM_DESC			, STATUS_ITEM
			, QTDEPACK				, MULTIPACK			, UPC_REAL			, DT_ALTERACAO		, DIGITO_UPC_REAL
			, TIPO_EAN_SAD			, SAMS_DIGITO_UPC
			, DT_INSERCAO_LOG
			, DESSINC_PRODUTO		, DESSINC_LOGIN
		)
		Select
			  XREF_BR_IF_ITEM_ID	, SAMS_ITEM_ID		, SAMS_UPC_NBR		, SAMS_VENDOR_NBR	, SAMS_PLU_NBR
			, SAD_CODPRODU			, SAD_CODIGO_EAN	, IDCARRINHOITEM	, ITEM_DESC			, STATUS_ITEM
			, QTDEPACK				, MULTIPACK			, UPC_REAL			, DT_ALTERACAO		, DIGITO_UPC_REAL
			, TIPO_EAN_SAD			, SAMS_DIGITO_UPC
			, @DhRetorno as DT_INSERCAO_LOG
			, 1 as DESSINC_PRODUTO	, @Login
		From
			XREF_BR_IF_ITEM as x 
			Inner Join @Produtos as p
				on p.ProdutoNbr = x.SAD_CODPRODU
		Where
			p.CodRetorno = '000'
	
	-- Remove a cross
	Delete From x
		From
			XREF_BR_IF_ITEM as x 
			Inner Join @Produtos as p
				on p.ProdutoNbr = x.SAD_CODPRODU
		Where
			p.CodRetorno = '000'

	-- Executa Scripts Adicionais
	Declare @dtSad varchar 
	Select @dtSad = FORMAT(@DhRetorno, 'yyyyMMdd') 

	Update SAD_PRODU 		Set SITUACAO = 'D', MAINT = 'D', DTDELECAO = @dtSad, CODIGO_EAN = '4000' + convert(varchar(30), p.ProdutoNbr), EANEMB = '4000' + convert(varchar(30), p.ProdutoNbr) 		From SAD_PRODU as s Inner Join @Produtos as p on s.CODPRODU = p.ProdutoNbr Where p.CodRetorno = '000'    Update SAD_PROFL 		Set SITUACAO = 'D', MAINT = 'D', DTSITUACAO = @dtSad 		From SAD_PROFL as s Inner Join @Produtos as p on s.PRODUT = p.ProdutoNbr Where p.CodRetorno = '000'    Update SAD_PORIT 		Set SITUACAO = 'D', DATADEL = @dtSad 		From SAD_PORIT as s Inner Join @Produtos as p on s.CODITEM = p.ProdutoNbr Where p.CodRetorno = '000'    Update SAD_MODAL 		Set SITUACAO = 'D', DTULTALTER = @dtSad 		From SAD_MODAL as s Inner Join @Produtos as p on s.CODPROD = p.ProdutoNbr Where p.CodRetorno = '000'    Update SAD_PREDT 		Set SIT = 'D' 		From SAD_PREDT as s Inner Join @Produtos as p on s.PE_CODITEM = p.ProdutoNbr Where p.CodRetorno = '000'    Update SAD_PROCE 		Set SIT = 'D', DT_SIT = @dtSad 		From SAD_PROCE as s Inner Join @Produtos as p on s.CODPROD = p.ProdutoNbr Where p.CodRetorno = '000'    Update SAD_NEAN  
		Set SITUACAO = 'D', COD_EAN = '4000' + convert(varchar(30), p.ProdutoNbr), EANEMB = '4000' + convert(varchar(30), p.ProdutoNbr) 
		From SAD_NEAN as s Inner Join @Produtos as p on s.COD_PRODU = p.ProdutoNbr Where p.CodRetorno = '000'

	Commit Transaction

	Select 0 as PossuiErro
End Try
Begin Catch

	Rollback Transaction

	Insert Into ApcmLog (
		Emissor, Tipo, Dh, Mensagem
	) Values (
		'Lote.RegistrarCarrinhoDessinc', 'Erro', @DhRetorno, 'Lote: ' + @NumeroLote + ', Linha: ' +  CONVERT(varchar, ERROR_LINE()) + ', Erro:' + CONVERT(VARCHAR, ERROR_NUMBER()) + ' - ' + ERROR_MESSAGE()
	)

	Select 1 as PossuiErro
End Catch