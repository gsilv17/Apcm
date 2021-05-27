Select
	  p.ITEM_NBR 		  as [Código do item SAM'S]
	, p.Descr 			  as [Descrição do item]
	, t.vendor_nbr		  as [Código do Vendor (6 digitos)]
	, t.descrVendor		  as [Descrição do vendor (nome)]
	, t.codCategoria	  as [Código da Categoria]
	, t.descrCategoria	  as [Descrição da Categoria]
	, t.codSubcategoria	  as [Código da Subcategoria]
	, t.descrSubcategoria as [Descrição da sub categoria]
From 
	SAD_ITEM_PRATELEIRA as p
	Inner Join ItemTransformado as t on p.item_nbr = t.item_nbr
	Left  Join XREF_BR_IF_ITEM as x on p.item_nbr = x.sams_item_id
Where
	x.XREF_BR_IF_ITEM_ID is null
Order By
	p.ITEM_NBR asc