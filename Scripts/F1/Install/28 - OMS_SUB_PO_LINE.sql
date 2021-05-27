
go
print 'F1 - 28'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OMS_SUB_PO_LINE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OMS_SUB_PO_LINE](
    [rowId] [int] IDENTITY(1,1) NOT NULL,
    [idLoad] [int] NULL,
    [OMS_SUB_ORDER_NBR] [numeric](10,0) NULL,
    [OMS_SUB_LINE_NBR] [int] NULL,
    [OMS_PO_NBR] [numeric](10,0) NULL,
    [OMS_PO_LINE_NBR] [int] NULL,
    [CREATE_TS] [datetime2] NULL) END


GO


