
go
print 'F1 - 22'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WC_CONS_ALIGN]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[WC_CONS_ALIGN]

END

go



