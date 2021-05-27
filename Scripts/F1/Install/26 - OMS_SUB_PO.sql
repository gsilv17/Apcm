
go
print 'F1 - 26'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OMS_SUB_PO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OMS_SUB_PO](
    [rowId] [int] IDENTITY(1,1) NOT NULL,
    [idLoad] [int] NULL,
    [OMS_SUB_ORDER_NBR] [numeric](10,0) NULL,
    [OMS_PO_NBR] [numeric](10,0) NULL,
    [XREF_PO_NBR] [nchar](10) NULL,
    [CREATE_TS] [datetime2] NULL,
    [XREF_BASE_DIV_NBR] [int] NULL,
    [OMS_SYNC_ID] [int] NULL,
    [OMS_SYNC_UPD_TS] [datetime2] NULL,
    [ORDER_OFFICE_ID] [int] NULL,
    [SYS_SEPARATOR_CD] [nchar](2) NULL,
    [PO_STOP_PRCSS_IND] [nchar](1) NULL,
    [PO_STOP_PRCSS_TS] [datetime2] NULL,
    [PO_FINISH_INS_IND] [nchar](1) NULL,
    [PO_FINISH_INS_TS] [datetime2] NULL,
    [TO_OMS_SYNC_TS] [datetime2] NULL,
    [FROM_OMS_SYNC_TS] [datetime2] NULL,
    [XREF_PO_ORDER_DATE] [date] NULL,
    [ROW_CHANGE_TS] [datetime2] NULL,
    [DC_SCHDL_ID] [int] NULL,
    [DC_SCHDL_DLVRY_DT] [date] NULL,
    [DC_SCHDL_DLVRY_TM] [time] NULL,
    [DC_SCHDL_STATUS_CD] [nchar](1) NULL,
    [NO_SCHDL_TYPE_CODE] [int] NULL,
    [DC_SCHDL_MSG_TS] [datetime2] NULL,
    [LIVE_DROP_IND] [nchar](1) NULL,
    [MABD_NO_MOVE_IND] [nchar](1) NULL) END



GO


