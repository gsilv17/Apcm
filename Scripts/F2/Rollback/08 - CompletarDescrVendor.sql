
go 
print 'F2 - 08 - CompletarDescrVendor' 
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompletarDescrVendor]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[CompletarDescrVendor]
END
GO

