
go 
print 'F2 - 05 - EstruturaMercadologica' 
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstruturaMercadologica]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[EstruturaMercadologica]
END

GO

