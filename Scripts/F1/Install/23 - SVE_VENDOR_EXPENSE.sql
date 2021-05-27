
go
print 'F1 - 23'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SVE_VENDOR_EXPENSE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SVE_VENDOR_EXPENSE](
    [RowId] [int] IDENTITY(1,1) NOT NULL,
    [IdLoad] [int] NULL,
    [DIV_NBR] [int] NULL,
    [DC_NBR] [int] NULL,
    [VENDOR_NBR] [int] NULL,
    [AUTH_IND] [nchar](1) NULL,
    [INBOUND_PCT] [numeric](5,3) NULL,
    [HANDLING_PCT] [numeric](5,3) NULL,
    [OUTBOUND_PCT] [numeric](5,3) NULL,
    [COMMISSION_PCT] [numeric](5,3) NULL,
    [ALIGNMENT_TYPE_CODE] [nchar](2) NULL,
    [OCEAN_PCT] [numeric](5,3) NULL,
    [RANDOM_PCT] [numeric](5,3) NULL,
    [VENDOR_PCT] [numeric](5,3) NULL,
    [TRUCKLOAD_IND] [nchar](1) NULL,
    [LAST_CHANGE_DATE] [date] NULL,
    [LAST_CHANGE_TIME] [time] NULL,
    [LAST_CHANGE_USERID] [nchar](8) NULL,
    [LAST_CHANGE_TERMINAL_ID] [nchar](4) NULL) END


GO


