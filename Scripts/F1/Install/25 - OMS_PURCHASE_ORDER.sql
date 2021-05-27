
go
print 'F1 - 25'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OMS_PURCHASE_ORDER]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OMS_PURCHASE_ORDER](
    [rowId] [int] IDENTITY(1,1) NOT NULL,
    [idLoad] [int] NULL,
    [OMS_PO_NBR] [numeric](10,0) NULL,
    [DC_NBR] [int] NULL,
    [DC_COUNTRY_CODE] [nchar](2) NULL,
    [VENDOR_NBR] [int] NULL,
    [ORDER_DATE] [date] NULL,
    [IMPORT_IND] [nchar](1) NULL,
    [TRANSMIT_STAT_CD] [int] NULL,
    [TRANSMIT_METHOD_CD] [nchar](1) NULL,
    [FRT_PYMNT_TYP_CODE] [int] NULL,
    [ORDER_OFFICE_ID] [int] NULL,
    [PO_STATUS_CD] [int] NULL,
    [PO_CREATE_TS] [datetime2] NULL,
    [PO_CLOSE_DATE] [date] NULL,
    [MANUAL_CREATE_IND] [nchar](1) NULL,
    [CREATE_USERID] [nchar](8) NULL,
    [CREATE_SYSTEM_ID] [nchar](8) NULL,
    [LAST_CHG_USERID] [nchar](8) NULL,
    [LAST_CHG_TS] [datetime2] NULL,
    [EDIT_LOCK_IND] [nchar](1) NULL,
    [EDIT_LOCK_USERID] [nchar](8) NULL,
    [EDIT_LOCK_TS] [datetime2] NULL,
    [EDIT_BLOCK_REASON_CD] [int] NULL,
    [SCAC_CODE] [nchar](6) NULL,
    [TRANS_MODE_CODE] [int] NULL,
    [BACKHAUL_IND] [nchar](1) NULL,
    [DEL_GATE_IN_DATE] [date] NULL,
    [DEL_GATE_IN_TIME] [time] NULL,
    [UNIT_CODE] [nchar](3) NULL,
    [DCS2000_IND] [nchar](1) NULL,
    [CONTRACT_CARRIER_IND] [nchar](1) NULL,
    [DC_APPOINTMENT_DATE] [date] NULL,
    [DC_APPOINTMENT_TIME] [time] NULL,
    [WHSE_AREA_CODE] [int] NULL,
    [WORK_ORDER_NBR] [numeric](10,0) NULL,
    [CAL_OTB_YEAR_NBR] [int] NULL,
    [CAL_OTB_MONTH_NBR] [int] NULL,
    [MABD_DATE] [date] NULL,
    [MABD_TIME] [time] NULL,
    [DNSB_DATE] [date] NULL,
    [DNSA_DATE] [date] NULL,
    [DNRB_DATE] [date] NULL,
    [DNRB_TIME] [time] NULL,
    [WM_OTB_YEAR_NBR] [int] NULL,
    [WM_OTB_MONTH_NBR] [int] NULL,
    [CREATE_REASON_CD] [int] NULL,
    [CO_MANAGE_IND] [nchar](1) NULL,
    [MANUAL_REPLEN_ORDER_IND] [nchar](1) NULL,
    [DCS2000_FREIGHT_CODE] [nchar](8) NULL,
    [ROW_CHANGE_TS] [datetime2] NULL,
    [IMPORT_DIV_NBR] [int] NULL,
    [IMPORT_SUPPLIER_ID] [int] NULL,
    [CREDIT_OFFICE_ID] [int] NULL,
    [LOGISTIC_OFFICE_ID] [int] NULL,
    [BENEFICIARY_ID] [int] NULL,
    [SECONDARY_BENEFICIARY_ID] [int] NULL,
    [BENEFICIARY_BANK_BRANCH_ID] [int] NULL,
    [MANAGING_BUYER_USERID] [nchar](10) NULL,
    [DESTINATION_COMPANY_ID] [int] NULL,
    [LOADING_PORT_ID] [int] NULL,
    [ENTRY_PORT_ID] [int] NULL,
    [DISCHARGE_PORT_ID] [int] NULL,
    [MFG_COMPANY_ID] [int] NULL,
    [ORIGIN_COUNTRY_CODE] [nchar](2) NULL,
    [CONSOLIDATOR_ID] [int] NULL,
    [PLACE_OF_POSS_CODE] [int] NULL,
    [PLACE_OF_POSS_DESC] [nchar](80) NULL,
    [IN_STORE_DATE] [date] NULL,
    [ORC_AUTHORIZE_DATE] [date] NULL,
    [ORC_RECEIVE_DATE] [date] NULL,
    [MUST_ARRIVE_PORT_DATE] [date] NULL,
    [INCOTERM_CODE] [nchar](3) NULL,
    [STORAGE_IND] [nchar](1) NULL,
    [CUSTOMS_BROKER_ID] [int] NULL,
    [BOOKING_ID] [int] NULL,
    [ORDER_BUS_FORMAT_CODE] [int] NULL,
    [EQUIPMENT_TYPE_CODE] [int] NULL,
    [CONTAINER_LOAD_QTY] [int] NULL,
    [BID_CURRENCY_CODE] [nchar](3) NULL,
    [IMPORT_DNSB_DATE] [date] NULL,
    [IMPORT_DNSA_DATE] [date] NULL,
    [LC_ID] [nchar](20) NULL,
    [QUOTE_ID] [int] NULL,
    [TRIP_ID] [int] NULL,
    [BUYING_AGENT_ID] [int] NULL,
    [DECONSOLIDATOR_ID] [int] NULL,
    [DELIVERY_SERVICE_CODE] [int] NULL,
    [CHG_REASON_CD] [int] NULL,
    [ORIG_MABD_DATE] [date] NULL,
    [MABD_CHG_INIT] [nchar](1) NULL,
    [BOOKING_PO_NBR] [numeric](11,0) NULL,
    [PO_ALLOC_RESERVE_NBR] [int] NULL,
    [PO_LOCK_TYPE_CODE] [int] NULL,
    [REMIX_PO_MAINT_IND] [nchar](1) NULL,
    [PO_TYPE_CD] [int] NULL,
    [WHSE_CHG_TS] [datetime2] NULL,
    [ACTION_TAKEN_BY] [nchar](8) NULL,
    [ACTION_TAKEN_TS] [datetime2] NULL,
    [REJECT_REASON] [nchar](255) NULL,
    [PICK_PO_IND] [nchar](1) NULL,
    [DC_APPOINTMENT_NBR] [int] NULL,
    [OTIF_MABD_DATE] [date] NULL) END



GO


