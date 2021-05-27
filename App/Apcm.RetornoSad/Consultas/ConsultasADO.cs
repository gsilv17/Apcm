using Apcm.RetornoSad.Businness;
using System;

namespace Apcm.RetornoSad.Consultas
{
    internal class ConsultasADO
    {
        internal static string ConsultarLotesNaoProcessados()
        {
            string sql = @"SELECT
	                        IdLote,
	                        ISNULL(NumeroLote,'') AS NumeroLote,
	                        ISNULL(IdCarrinho,0) AS IdCarrinho
                        FROM
	                        LOTE
                        WHERE
	                        ISNULL(STATUSRETORNO,'') = ''
	                        AND ISNULL(NumeroLote,'') <> ''";
            return sql;
        }

        internal static string InserirCarrinhoItemLote(int idCarrinhoItem, int idLote, string codRetorno, string statusRetorno, int filial)
        {
            string sql = string.Format(@"INSERT INTO CARRINHOITEMLOTE VALUES({0}, {1}, '{2}', '{3}', {4} )", idCarrinhoItem, idLote, codRetorno, statusRetorno, filial);
            return sql;
        }

        internal static string AtualizarCarrinhoItem(int idCarrinhoItem)
        {
            string sql = string.Format("UPDATE CARRINHOITEM SET EmEdicao = 0, DhUltimaAlteracao = GETDATE() WHERE IdCarrinhoItem = {0}", idCarrinhoItem);
            return sql;
        }

        internal static string AtualizarLote(int idLote,  string statusRetorno)
        {
            string sql = string.Format("UPDATE LOTE SET DhRetorno = GETDATE(), StatusRetorno = '{0}' WHERE IdLote = {1}", statusRetorno, idLote);
            return sql;
        }

        internal static string ObterIdCrossItem(int  idCarrinhoItem)
        {
            string sql = string.Format(@"SELECT
	                                        ISNULL(XREF_BR_IF_ITEM_ID,0) AS IDCROSSITEM
                                        FROM
	                                        XREF_BR_IF_ITEM A 
	                                        JOIN CARRINHOITEM B
		                                        ON A.SAMS_ITEM_ID = B.ITEM_NBR
                                        WHERE
	                                        B.IDCARRINHOITEM = {0}
                                        ", idCarrinhoItem);
            return sql;
        }

        internal static string ObterIdCrossProduto(int idCarrinhoItem)
        {
            string sql = string.Format(@"
Select
	x.XREF_BR_IF_ITEM_ID
From
	XREF_BR_IF_ITEM as x
	Inner Join CarrinhoItem as ci on ci.produto_nbr = x.SAD_CODPRODU
Where
	ci.IdCarrinhoItem = {0}", idCarrinhoItem);
            return sql;
        }

        internal static string InserirCrossItem(CrossItem dados)
        {
            string sql = string.Format(@"INSERT INTO XREF_BR_IF_ITEM VALUES({0},{1},'{2}',{3},{4},{5},{6},'{7}','{8}',{9},'{10}',{11},GETDATE(),{12}, {13}, {14})"
                                    , dados.SamsItemId, dados.SamsUpcNbr, dados.SamsVendorNbr, dados.SamsPluNbr, dados.SadCodProdu, dados.SadCodigoEan, dados.IdCarrinhoItem,
                             dados.ItemDesc, dados.StatusItem, dados.Qtdepack, dados.Multipack, dados.UpcReal, dados.DigitoUpcReal, dados.TipoEan, dados.EanDig);
            return sql;
        }

        internal static string ObterDadosCarrinhoItem(int idCarrinhoItem)
        {
            string sql = string.Format(@"SELECT
	                                    CAST(ISNULL(CARIT.produto_nbr, '0') AS INT) AS CodProdutoSAD
	                                    ,ISNULL(CARIT.item1_desc, '') AS DescricaoItem
	                                    ,ISNULL(CARIT.vendor_nbr, '') AS CodVendor
	                                    ,ISNULL(CARIT.DescrVendor, '') AS DescVendor
	                                    ,CAST(ISNULL(CARIT.codCategoria, '0') AS INT) AS CodigoCategoria
	                                    ,ISNULL(CARIT.DescrCategoria, '') AS DescCategoria
	                                    ,CAST(ISNULL(CARIT.codSubcategoria, '0') AS INT) AS CodigoSubCategoria
	                                    ,ISNULL(CARIT.DescrSubCategoria, '') DescSubCategoria
	                                    ,CAST(ISNULL(CARIT.item_nbr, '0') AS INT) AS CodItemOif
	                                    ,CONVERT(VARCHAR(10),ISNULL(CARIT.DhSelecionado, GETDATE()), 103) AS DiaHoraSelecionado
	                                    ,CAST(ISNULL(CARIT.CodFineLine,'0') AS INT) AS CodFineLine
	                                    ,CASE WHEN ISNULL(MULTPK,'N') = 'S' THEN
											CASE WHEN ISNULL(CARIT.UPCR,'0') = '' THEN '0' ELSE  ISNULL(CARIT.UPCR,'0') END
										ELSE
											CASE WHEN ISNULL(CARIT.upc_original,'0') = '' THEN '0' ELSE ISNULL(CARIT.upc_original,'0') END
										END AS Upc
	                                    ,ISNULL(CARIT.descsinal,'') AS SigningDesc
	                                    ,0 AS VnpkQty --ISNULL(CARIT.vnpk_qty,0) AS VnpkQty
	                                    ,ISNULL(CARIT.ceaneb,0) AS CaseUpc
										,ISNULL(MULTPK, 'N') AS MultiPack
                                        ,CASE WHEN ISNULL(UPCRDG,'0') = '' THEN '0' ELSE  ISNULL(UPCRDG,'0') END AS DigitoUpcReal
	                                    ,0 MdseOrignCode--MdseOrignCode--ISNULL(CARIT.mdse_orign_code,0) AS MdseOrignCode  
	                                    ,0 MdseClasfCode--MdseClasfCodeISNULL(CARIT.mdse_clasf_code, '') AS MdseClasfCode,
	                                    ,0 VendorStockId--ISNULL(CARIT.vendor_stock_id,'') AS VendorStockId,
	                                    ,0 VnpkCosAmt--ISNULL(CARIT.vnpk_cost_amt,0) AS VnpkCosAmt,
	                                    ,0 ItemLengthQty--ISNULL(CARIT.item_length_qty,0) AS ItemLengthQty,
	                                    ,0 ItemWidthQty --ISNULL(CARIT.item_width_qty,0) AS ItemWidthQty,
	                                    ,0 ItemHeightQty--ISNULL(CARIT.item_height_qty,0) AS ItemHeightQty,
	                                    ,0 MiRrcvngDaysQty--ISNULL(CARIT.min_rcvng_days_qty,0) AS MiRrcvngDaysQty,
	                                    ,0 IpiTaxClassCd--ISNULL(CARIT.ipi_tax_class_cd,0) AS IpiTaxClassCd
                                        ,CAST(CASE WHEN ISNULL(CONV, '') = '' THEN '0' ELSE CONV END AS DECIMAL(10,0)) AS PackFornecedor
                                    FROM
	                                    CarrinhoItem CARIT
                                    WHERE
	                                    CARIT.IDCARRINHOITEM = {0}", idCarrinhoItem);
            return sql;
        }

        internal static string ObterCrossItem(int idCross)
        {
            string sql = string.Format(@"SELECT
	                                        ISNULL(SAMS_ITEM_ID,0) AS SamsItemId,
	                                        ISNULL(SAMS_UPC_NBR,0) AS SamsUpcNbr,
	                                        ISNULL(SAMS_VENDOR_NBR, '') AS SamsVendorNbr, 
	                                        ISNULL(SAMS_PLU_NBR, 0) AS SamsPluNbr,
	                                        ISNULL(SAD_CODPRODU,0) AS SadCodProdu,
	                                        ISNULL(SAD_CODIGO_EAN, 0) SadCodigoEan,
	                                        ISNULL(IDCARRINHOITEM,0) AS IdCarrinhoItem,
	                                        ISNULL(ITEM_DESC, '') AS ItemDesc,
	                                        ISNULL(STATUS_ITEM, '') AS StatusItem,
	                                        ISNULL(QTDEPACK, 0) AS  Qtdepack,
	                                        ISNULL(MULTIPACK, '') AS Multipack,
	                                        ISNULL(UPC_REAL, 0) AS UpcReal,
	                                        CONVERT(VARCHAR(10),DT_ALTERACAO, 103) AS  DtAlteração,
                                            ISNULL(DIGITO_UPC_REAL,0) AS DigitoUpcReal,
                                            ISNULL(TIPO_EAN_SAD,0) AS TipoEan,
                                            ISNULL(SAMS_DIGITO_UPC,0) AS EanDig
                                        FROM 
	                                        XREF_BR_IF_ITEM
                                        WHERE
	                                        XREF_BR_IF_ITEM_ID = {0}
                                        ", idCross);
            return sql;
        }

        internal static string InserirCrossItemLog(CrossItem dados, int idCross)
        {
            string sql = string.Format(@"INSERT INTO XREF_BR_IF_ITEM_LOG VALUES({0}, {1},{2},'{3}',{4},{5},{6},{7},'{8}','{9}',{10},'{11}',{12},CONVERT(DATETIME,'{13}',103), GETDATE(), {14}, {15}, {16})",
                                 idCross  , dados.SamsItemId, dados.SamsUpcNbr, dados.SamsVendorNbr, dados.SamsPluNbr, dados.SadCodProdu, dados.SadCodigoEan, dados.IdCarrinhoItem,
                             dados.ItemDesc, dados.StatusItem, dados.Qtdepack, dados.Multipack, dados.UpcReal, dados.DtAlteração, dados.DigitoUpcReal, dados.TipoEan, dados.EanDig);
            return sql;
        }

        internal static string AtualizarCrossItem(CrossItem dados, int idCross, string eanSAD)
        {
            dados.SadCodigoEan = eanSAD;
            string sql = string.Format(@"UPDATE
	                                        XREF_BR_IF_ITEM
                                        SET
	                                        SAMS_ITEM_ID = {0},
	                                        SAMS_UPC_NBR = {1},
	                                        SAMS_VENDOR_NBR = '{2}',
	                                        SAMS_PLU_NBR = {3},
	                                        SAD_CODPRODU = {4},
	                                        SAD_CODIGO_EAN = {5},
	                                        IDCARRINHOITEM = {6},
	                                        ITEM_DESC = '{7}',
	                                        STATUS_ITEM = '{8}',
	                                        QTDEPACK = {9},
	                                        MULTIPACK = '{10}',
	                                        UPC_REAL ={11},
	                                        DT_ALTERACAO = GETDATE(),
                                            DIGITO_UPC_REAL = {12},
                                            TIPO_EAN_SAD= {13},
                                            SAMS_DIGITO_UPC = {14}
                                        WHERE
	                                        XREF_BR_IF_ITEM_ID = {15}", dados.SamsItemId, dados.SamsUpcNbr, dados.SamsVendorNbr, dados.SamsPluNbr,
                                            dados.SadCodProdu, dados.SadCodigoEan, dados.IdCarrinhoItem, dados.ItemDesc, dados.StatusItem, dados.Qtdepack,
                                            dados.Multipack, dados.UpcReal, dados.DigitoUpcReal,dados.TipoEan, dados.EanDig, idCross);
            return sql;
        }

        internal static string AtualizarCrossProduto(int idCarrinhoItem)
        {
            string sql = string.Format(@"
Insert Into XREF_BR_IF_ITEM_LOG (
		  XREF_BR_IF_ITEM_ID		, SAMS_ITEM_ID			, SAMS_UPC_NBR		, SAMS_VENDOR_NBR
		, SAMS_PLU_NBR				, SAD_CODPRODU			, SAD_CODIGO_EAN	, IDCARRINHOITEM
		, ITEM_DESC					, STATUS_ITEM			, QTDEPACK			, MULTIPACK
		, UPC_REAL					, DT_ALTERACAO			, DT_INSERCAO_LOG	, DIGITO_UPC_REAL
		, TIPO_EAN_SAD				, SAMS_DIGITO_UPC		
	)
Select 
		  x.XREF_BR_IF_ITEM_ID		, x.SAMS_ITEM_ID		, x.SAMS_UPC_NBR	, x.SAMS_VENDOR_NBR
		, x.SAMS_PLU_NBR			, x.SAD_CODPRODU		, x.SAD_CODIGO_EAN	, x.IDCARRINHOITEM
		, x.ITEM_DESC				, x.STATUS_ITEM			, x.QTDEPACK		, x.MULTIPACK
		, x.UPC_REAL				, x.DT_ALTERACAO		, GETDATE()			, x.DIGITO_UPC_REAL
		, x.TIPO_EAN_SAD			, x.SAMS_DIGITO_UPC	
From
	XREF_BR_IF_ITEM as x
	Inner Join CarrinhoItem as ci on ci.produto_nbr = x.SAD_CODPRODU
Where
	ci.IdCarrinhoItem = {0}
	
Update XREF_BR_IF_ITEM Set
	SAD_CODIGO_EAN		= convert(numeric(18,0), Case When isnumeric(ci.Cean) = 0 Then null Else ci.Cean End)
	, ITEM_DESC			= ci.item1_desc
	, QTDEPACK			= convert(int, round(convert(decimal, Case When isnumeric(ci.Conv) = 0 Then null Else ci.Conv End), 0)) -- OBS.: Perda de precisão!!!!!!!!
	, MULTIPACK			= convert(char(1), SUBSTRING(ci.Multpk, 1, 1))
	, UPC_REAL			= convert(numeric(18,0), Case When isnumeric(ci.Upcr) = 0 Then null Else ci.Upcr End)
	, DIGITO_UPC_REAL	= convert(int, round(convert(decimal, Case When isnumeric(ci.Upcrdg) = 0 Then null Else ci.Upcrdg End), 0))
	, TIPO_EAN_SAD		= convert(int, round(convert(decimal, Case When isnumeric(ci.Tean) = 0 Then null Else ci.Tean End), 0))
	, DT_ALTERACAO		= GETDATE()
    , IDCARRINHOITEM	= ci.IdCarrinhoItem
From
	XREF_BR_IF_ITEM as x
	Inner Join CarrinhoItem as ci on ci.produto_nbr = x.SAD_CODPRODU
Where
	ci.IdCarrinhoItem = {0}
            ", idCarrinhoItem);
            return sql;
        }

        internal static string InserirControle(string proccess)
        {
            string sql = string.Format(@"INSERT INTO REPL_CTRL(FROM_TIME, STATUS, PROCESS, MENSAGEM) VALUES(GETDATE(), 1, '{0}', 'Em processamento')
                                        SELECT TOP 1 ID_REPL FROM REPL_CTRL ORDER BY 1 DESC", proccess);
            return sql;
        }

        internal static string AtualizarControle(int idProcess, int totalLoteProcessado)
        {
            string sql = string.Format("UPDATE REPL_CTRL SET STATUS = 0, TO_TIME = GETDATE(), MENSAGEM = 'Finalizado. O Total de lotes processados foi {0}' WHERE ID_REPL = {1}", totalLoteProcessado, idProcess);
            return sql;
        }

        internal static string ObterCodOrigem(int idCarrinhoItem)
        {
            string sql = string.Format(@"
Select
	Isnull(c.CodOrigem, 'Sams') as CodOrigem
From
	Carrinho as c
	Inner Join CarrinhoItem as ci on ci.IdCarrinho = c.IdCarrinho
Where
	ci.IdCarrinhoItem = {0}", idCarrinhoItem);
            return sql;
        }
    }
}
