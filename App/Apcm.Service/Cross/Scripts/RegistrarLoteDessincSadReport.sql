-- Cross.RegistrarLoteDessincSadReport

/*
	Declare @Dados varchar(4000) = '{"Ids":[1],"NumeroLote":"123"}'
--*/

Declare @Ids as table (Id int)
Declare	@NumeroLote varchar(20)

Insert Into @Ids
	Select Id From
		openjson(@Dados) with (
			Ids nvarchar(max) '$.Ids' as json
		)
		Outer Apply openjson(Ids) with (
			Id int '$'
		);

Select @NumeroLote = NumeroLote From
	openjson(@Dados) with (
		NumeroLote varchar(20) '$.NumeroLote'
	);

Update DessincSadReport Set NumeroLoteSadReport = @NumeroLote
	From 
		DessincSadReport as dsr
		Inner Join @Ids as ids
			on ids.Id = dsr.IdDessincSadReport