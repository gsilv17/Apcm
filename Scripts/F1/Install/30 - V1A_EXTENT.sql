
go
print 'F1 - 30'
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[V1A_EXTENT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[V1A_EXTENT](
    [rowId] [int] IDENTITY(1,1) NOT NULL,
    [idLoad] [int] NULL,
    [VENDOR_NBR] [int] NULL,
    [COUNTRY_CODE] [nchar](2) NULL,
    [LANGUAGE_CODE] [nchar](3) NULL,
    [CURRENCY_CODE] [nchar](3) NULL,
    [TAX_ID_NBR] [nchar](20) NULL,
    [VNDR_QTR1_BEGIN] [nchar](4) NULL,
    [VNDR_QTR2_BEGIN] [nchar](4) NULL,
    [VNDR_QTR3_BEGIN] [nchar](4) NULL,
    [VNDR_QTR4_BEGIN] [nchar](4) NULL,
    [BANK_ACCOUNT_NBR] [nchar](20) NULL,
    [PAYMENT_TYPE_CODE] [int] NULL,
    [BANK_ID] [nchar](11) NULL,
    [ACCT_HOLDER_NAME] [nchar](30) NULL,
    [PLT_LYR_ORD_IND] [nchar](1) NULL,
    [AUTO_CLM_DEDCT_IND] [nchar](1) NULL,
    [TAX_ID_NORM_IND] [nchar](1) NULL,
    [AP_COMPANY_ID] [int] NULL,
    [BANK_SWIFT_CODE] [nchar](8) NULL,
    [EAN_LOCTN_NBR] [numeric](13,0) NULL,
    [TELEPHONE_NBR] [nchar](18) NULL,
    [FAX_NBR] [nchar](18) NULL,
    [BUSINESS_TYPE_CODE] [int] NULL,
    [MDSE_TYPE_CODE] [int] NULL,
    [BRANCH_SWIFT_CODE] [nchar](3) NULL,
    [INVC_PMT_FREQ_CODE] [int] NULL,
    [AR_CLAIM_DEDCT_IND] [nchar](1) NULL,
    [VENDOR_LEGAL_NAME] [nchar](60) NULL,
    [INTRANATL_STAT_IND] [nchar](1) NULL,
    [TAX_CODE] [nchar](2) NULL,
    [RESPONSIBLE_USERID] [nchar](8) NULL,
    [TAX_AREA_TYPE_CODE] [nchar](2) NULL,
    [TAX_NAME_SEQ_NBR] [int] NULL,
    [TAX_WTHLD_TYPE_CD] [int] NULL,
    [TAX_REGIMAN_CD] [int] NULL,
    [TAX_AGENT_IND] [nchar](1) NULL,
    [PMN_BARRED_IND] [nchar](1) NULL,
    [FCTR_NAME_TYP_CODE] [int] NULL) END
GO

