truncate table Transformacoes

insert into Transformacoes 
	  ( nome								, ordemExec , ativa	, detalhes ) values
	  ('IniciarItemTransformado'			, '001'		, 1		, '(proc04) Carga inicial')
	, ('DefinirEstruturaMercadologica'		, '002'		, 1		, '(proc06) Obt�m a Estrutura Mercadol�gica a partir dos Itens')
	, ('CompletarEstruturaMercadologica'	, '002_001'	, 1		, '(proc07) Preenche a descri��o da estrutura mercadologica no item transformado')
	, ('CompletarDescrVendor'				, '003'		, 1		, '(proc08) Obt�m o nome do vendor')