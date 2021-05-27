
go
print 'F1 - 29'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VENDOR]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[VENDOR](
    [rowId] [int] IDENTITY(1,1) NOT NULL,
    [idLoad] [int] NULL,
    [VENDOR_NBR] [int] NULL,
    [TAX_TYPE] [char](1) NULL,
    [FEDERAL_TAX_ID] [int] NULL,
    [STATUS_CODE] [char](1) NULL,
    [VENDOR_TYPE] [char](1) NULL,
    [EXPENSE_TYPE] [char](1) NULL,
    [REMIT_NAME] [char](30) NULL,
    [REMIT_STREET_ADDR] [char](30) NULL,
    [REMIT_BLDG_ADDR] [char](30) NULL,
    [REMIT_CITY_ADDRESS] [char](30) NULL,
    [REMIT_STATE_CODE] [char](2) NULL,
    [REMIT_ZIP_CODE] [numeric](9,0) NULL,
    [REMIT_ADDR_PRT_FL] [char](1) NULL,
    [FACTOR_NAME] [char](30) NULL,
    [HOLD_PAYMENT_FLAG] [char](1) NULL,
    [YTD_EXPENSE_AMOUNT] [numeric](11,2) NULL,
    [DELETE_DATE] [date] NULL,
    [CREATE_DATE] [date] NULL,
    [CHANGE_DATE] [date] NULL,
    [CHANGE_INITIALS] [char](3) NULL,
    [FEDERAL_CORP_CODE] [char](1) NULL) END


GO


