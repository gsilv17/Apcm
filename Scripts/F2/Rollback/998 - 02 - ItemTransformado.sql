
go
print 'F2 - 02 - ItemTransformado'
go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTransformado]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[ItemTransformado]
END

GO

