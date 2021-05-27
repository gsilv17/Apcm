
go 
print 'F2 - 08 - CompletarDescrVendor' 
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompletarDescrVendor]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CompletarDescrVendor] AS' 
END
GO

ALTER procedure [dbo].[CompletarDescrVendor] (
	@IdLoad int,
	@Registros int output
)

As

Begin

Update ItemTransformado Set
	descrVendor = v.REMIT_NAME
From	
	ItemTransformado as i
	Inner Join VENDOR as v on 
		v.vendor_nbr = i.vendor_nbr
Where
	i.descrVendor is null

Set @registros = @@ROWCOUNT

End

GO

