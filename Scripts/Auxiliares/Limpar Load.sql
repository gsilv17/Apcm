

Declare @idLoad int = -1 -- 0 para todos ou o load específico.

if @idLoad = 0 
	Begin
		Truncate Table ITEM
		Truncate Table CLUB_ITEM
		Truncate Table CLUB_ITEM_INVT
		Truncate Table ITEM_DC
		Truncate Table SCALABLE_ITEM
		Truncate Table SCALABLE_ITEM_WC
		Truncate Table ITEM_EST_COST
		Truncate Table ITEM_COST_CMPNT
		Truncate Table PRICING_ACTION
		Truncate Table PRICE_DESTINATION
		Truncate Table BR_ITEM_TAX
		Truncate Table BR_TAX_NCM
		Truncate Table BR_ITEM_TAX_PRMTR
		Truncate Table BR_INBOUND_IPI
		Truncate Table logTSamsF1	
		Truncate Table loadTSams	
	End
Else 
	Begin
		Delete From ITEM				Where idLoad = @idLoad
		Delete From CLUB_ITEM			Where idLoad = @idLoad
		Delete From CLUB_ITEM_INVT		Where idLoad = @idLoad
		Delete From ITEM_DC				Where idLoad = @idLoad
		Delete From SCALABLE_ITEM		Where idLoad = @idLoad
		Delete From SCALABLE_ITEM_WC	Where idLoad = @idLoad
		Delete From ITEM_EST_COST		Where idLoad = @idLoad
		Delete From ITEM_COST_CMPNT		Where idLoad = @idLoad
		Delete From PRICING_ACTION		Where idLoad = @idLoad
		Delete From PRICE_DESTINATION	Where idLoad = @idLoad
		Delete From BR_ITEM_TAX			Where idLoad = @idLoad
		Delete From BR_TAX_NCM			Where idLoad = @idLoad
		Delete From BR_ITEM_TAX_PRMTR 	Where idLoad = @idLoad
		Delete From BR_INBOUND_IPI		Where idLoad = @idLoad
		Delete From logTSamsF1			Where idLoad = @idLoad
		Delete From loadTSams			Where idLoad = @idLoad
	end