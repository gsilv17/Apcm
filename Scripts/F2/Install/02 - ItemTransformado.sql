
go
print 'F2 - 02 - ItemTransformado'
go

/****** Object:  Table [dbo].[ItemTransformado]    Script Date: 13/03/2020 09:07:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemTransformado]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemTransformado](
	[rowId] [int] NOT NULL,						-- 
	[idLoad] [int] NOT NULL,					-- 
	[item_nbr] [int] NOT NULL,					-- Item
	[codCategoria] [int] NOT NULL,				-- Cod Categoria
	[descrCategoria] [varchar](60) NULL,		-- Descr Categoria
	[codSubcategoria] [int] NOT NULL,			-- Cod Subcategoria
	[descrSubcategoria] [varchar](60) NULL,		-- Descr Subcategoria
	[codFineline] [int] NOT NULL,				-- Cod fineline
	[descrFineline] [varchar](60) NULL,			-- Descr Fineline
	[vendor_nbr] [int] NOT NULL,				-- Vendor Nbr
	[descrVendor] [varchar](60) NULL,			-- Descr Vendor
	[upc_original] [varchar](15) NULL,			-- UPC_NBR > upc_original

	[item_type_code] [int] NULL					
	/*
	[produto_nbr] [int] NULL,					-- Produto
	[upc_nbr] [numeric](15, 0) NULL,			-- UPC
	[item_status] [char](1) NULL,				-- Status
	[item_create_dt] [date] NULL,				-- Data Criação
	[item1_desc] [varchar](25) NULL, -- trim	-- 1st Description
	[last_update_user_id] [varchar](10) NULL,	-- Id editor
	[last_update_ts] [datetime2](7) NULL,		-- Last Update
	[signing_desc] [varchar](40) NULL,			-- Signing 1 Desc
	[vnpk_qty] [int] NULL,						-- Orderable Qty
	[case_upc_nbr] [numeric](15, 0) NULL,		-- Orderable GTIN
	[mdse_orign_code] [int] NULL,				-- Merchandise Origin
	[mdse_clasf_code] [varchar](15) NULL,		-- Merchandise Classification Code
	[vendor_stock_id] [varchar](20) NULL,		-- Supplier Stock Id
	[vnpk_cost_amt] [numeric](13, 4) NULL,		-- Supplier Pack Cost
	[item_length_qty] [numeric](9, 3) NULL,		-- Orderable Depth
	[item_width_qty] [numeric](9, 3) NULL,		-- Orderable Width
	[item_height_qty] [numeric](9, 3) NULL,		-- Orderable Height
	[min_rcvng_days_qty] [int] NULL,			-- Variance days
	[ipi_tax_class_cd] [int] NULL,				-- IPI Stamp Class
	*/

 CONSTRAINT [PK_ItemTransformado] PRIMARY KEY CLUSTERED 
(
	[rowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO



