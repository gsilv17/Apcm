

go
print 'F2 - 03 - LogTSamsF2'
go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LogTSamsF2]') AND type in (N'U'))
BEGIN
DROP TABLE [dbo].[LogTSamsF2]
END

GO


