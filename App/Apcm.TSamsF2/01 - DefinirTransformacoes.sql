truncate table Transformacoes

insert into Transformacoes 
	  ( nome								, ordemExec , ativa	, detalhes ) values
	  ('IniciarItemTransformado'			, '001'		, 1		, '(proc04) Carga inicial')
	, ('DefinirEstruturaMercadologica'		, '002'		, 1		, '(proc06) Obtém a Estrutura Mercadológica a partir dos Itens')
	, ('CompletarEstruturaMercadologica'	, '002_001'	, 1		, '(proc07) Preenche a descrição da estrutura mercadologica no item transformado')
	, ('CompletarDescrVendor'				, '003'		, 1		, '(proc08) Obtém o nome do vendor')