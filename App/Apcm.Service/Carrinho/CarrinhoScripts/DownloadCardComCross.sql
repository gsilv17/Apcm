﻿-- Carrinho.DownloadCardComCrossSelect 	p.ITEM_NBR				as [Código do Item SAM'S]	, x.SAD_CODPRODU		as [Código do Produto]	, p.Descr				as [Descrição do item]	, x.Sams_Vendor_Nbr		as [Vendor Number]	, x.SAD_CODIGO_EAN		as [Ean]	, x.Upc_Real			as [UPC Real]	, i.Plu_nbr				as [PLU]	, x.QtdePack			as [Pack]	, Case 		When ISNULL(x.MULTIPACK, '') = 'N' Then 			'Não' 		Else 			'Sim' 	End						as [Multipack]	, i.item_type_code		as [Tipo Item]	, Case 		When ISNULL(ci.Ra, '') = '' Or ci.Ra = 'N' Then			'Não'		Else 			'Sim'	End						as [Flag RA]	, e.N4SAD_SECAOID		as [Cód. Seção]	, e.N4SAD_SECAO			as [Seção]	, e.N5SAD_LINHAID		as [Cód. Linha]	, e.N5SAD_LINHA			as [Linha]	, e.N6SAD_SUBLINHAID	as [Cód. Sublinha]	, e.N6SAD_SUBLINHA		as [Sublinha]	, x.Dt_alteracao		as [Data]	, u.[Login]				as [Login de Rede]	, u.Nome				as [Nome]	, u.LoginSad			as [Login SAD]From 	SAD_ITEM_PRATELEIRA					as p	Inner Join ItemTransformado			as t 		on p.item_nbr = t.item_nbr	Inner Join Item						as i 		on i.ITEM_NBR = t.item_nbr	Inner Join XREF_BR_IF_ITEM			as x 		on p.item_nbr = x.sams_item_id	Inner Join CarrinhoItem				as ci 		on ci.IdCarrinhoItem = x.IDCARRINHOITEM	Inner Join Carrinho					as c 		on c.IdCarrinho = ci.IdCarrinho	Inner Join TSamsF3User				as u 		on u.[Login] = c.[Login]	Left Join IF_HIERARCHY_XREF_SAMS	as e 		on e.n4wm_categid = t.codCategoria		and e.n5Wm_SubCatId = t.codSubcategoria		and e.N6Wm_FinelineId = t.codFinelineOrder By	p.ITEM_NBR asc