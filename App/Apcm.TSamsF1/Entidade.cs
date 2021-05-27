using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Apcm.TSamsF1
{
    class Entidade
    {
        public readonly string Schema;
        public readonly string Nome;
        public readonly string CampoDataAlteracao;
        public readonly string Join;
        public readonly string Filtro;
        public readonly List<string> Chaves;
        public readonly bool PossuiCampoDataAlteracao;

        private Entidade(string schema, string nome, string campoDataAlteracao, string join, string filtro, params string[] chaves)
        {
            Schema = schema;
            Nome = nome;
            CampoDataAlteracao = campoDataAlteracao;
            Join = join;
            Filtro = filtro;
            Chaves = chaves.ToList();
            PossuiCampoDataAlteracao = !string.IsNullOrEmpty(CampoDataAlteracao);
        }

        public static List<Entidade> ObterEntidades()
        {

#if DEBUG
            return new List<Entidade>
            {

                new Entidade(
                    schema: "gksamitm",
                    nome: "item",
                    campoDataAlteracao: string.Empty, // "last_update_ts",
                    join: string.Empty,
                    filtro: string.Empty,
                    chaves: "item_nbr"),
                //new Entidade("gksamitm", "club_item", string.Empty, string.Empty, string.Empty, "item_nbr", "club_nbr"),
                new Entidade("gksamitm", "club_item_invt", "last_change_ts", string.Empty, string.Empty, "item_nbr", "club_nbr"),
                //new Entidade("gksamitm", "item_dc", string.Empty, string.Empty, string.Empty, "item_nbr", "dc_nbr"),
                new Entidade("gkscmgmt", "scalable_item", "last_chg_timestamp", string.Empty, string.Empty, "plu_item_nbr", "country_code"),
                new Entidade("gkscmgmt", "scalable_item_wc", "last_chg_timestamp", string.Empty, string.Empty, "plu_item_nbr", "country_code"),
                new Entidade("gkSPRICE", "item_est_cost", "last_update_ts", string.Empty, string.Empty, "item_est_cost_id"),
                new Entidade("gkSPRICE", "item_cost_cmpnt", "last_update_ts", string.Empty, string.Empty, "item_est_cost_id", "cost_cmpnt_type_code"),
                new Entidade("gkSPRICE", "pricing_action", "last_change_ts", string.Empty, string.Empty,  "pricing_action_id"),
                new Entidade("gkSPRICE", "price_destination", string.Empty, string.Empty, string.Empty),
                new Entidade("gkSAMTAX", "br_item_tax", "last_change_ts", string.Empty, string.Empty, "item_nbr"),
                new Entidade("gkTXRULE", "br_tax_ncm", "last_change_ts", string.Empty, string.Empty, "ncm_id"),
                new Entidade("gkSAMTAX", "br_item_tax_prmtr", "last_change_ts", string.Empty, string.Empty, "item_nbr"),
                new Entidade("gkSAMTAX", "br_inbound_ipi", "last_change_ts", string.Empty, string.Empty, "item_nbr", "effective_date"),
                new Entidade("gkSAMITM", "department_desc", string.Empty, string.Empty, string.Empty),
                new Entidade("gkSAMITM", "subclass_text", string.Empty, string.Empty, string.Empty),
                new Entidade("gkSAMITM", "subclass_fnln_text", string.Empty, string.Empty, string.Empty),
                new Entidade("gkSAMITM", "upc_item", string.Empty, string.Empty, string.Empty, "upc_nbr", "item_nbr"),
                new Entidade("gkSWC001", "wc_cons_align", string.Empty, string.Empty, string.Empty),
                new Entidade("GKLGITFC", "sve_vendor_expense", string.Empty, string.Empty, string.Empty),

                new Entidade("GKSWCITM", "addl_desc", string.Empty, string.Empty, string.Empty),
                //new Entidade("bromspo", "oms_purchase_order", "last_chg_ts", string.Empty, string.Empty, "oms_po_nbr"),
                //new Entidade("bromspo", "oms_sub_po", "row_change_ts", string.Empty, string.Empty, "oms_sub_order_nbr"),
                //new Entidade("bromspo", "oms_po_line", "row_change_ts", string.Empty, string.Empty, "oms_po_nbr", "oms_po_line_nbr"),
                //new Entidade("bromspo", "oms_sub_po_line", "create_ts", string.Empty, string.Empty, "oms_sub_order_nbr", "oms_sub_line_nbr"),

                new Entidade("gkSAMITM", "sams_item_alt_sell_uom", "last_update_ts", string.Empty, string.Empty, "item_nbr", "alt_sell_uom_code"),

                //new Entidade("brsams", "vendor", "change_date", string.Empty, string.Empty, "vendor_nbr"),

                new Entidade("CTSGPGK", "vendor", "change_date", string.Empty, string.Empty, "vendor_nbr"),
                //new Entidade("gkVENDOR", "v1a_extent", string.Empty, string.Empty, string.Empty),
                new Entidade("SAMRMTGK", "division", string.Empty, string.Empty, string.Empty),

                new Entidade("SAMRMTGK", "UOM_TEXT", string.Empty, string.Empty, "And Language_Code = '105'")
            };
            
#else
            return new List<Entidade>
            {
                new Entidade(
                    schema: "brsamitm",
                    nome: "item",
                    campoDataAlteracao: string.Empty, // "last_update_ts",
                    join: string.Empty,
                    filtro: string.Empty,
                    chaves: "item_nbr"),
                //new Entidade("brsamitm", "club_item", "last_change_ts", string.Empty, string.Empty, "item_nbr", "club_nbr"),
                //new Entidade("brsamitm", "club_item", string.Empty, string.Empty, string.Empty, "item_nbr", "club_nbr"),
                new Entidade("brsamitm", "club_item_invt", "last_change_ts", string.Empty, string.Empty, "item_nbr", "club_nbr"),
                //new Entidade("brsamitm", "item_dc", "last_update_ts", string.Empty, string.Empty, "item_nbr", "dc_nbr"),
                //new Entidade("brsamitm", "item_dc", string.Empty, string.Empty, string.Empty, "item_nbr", "dc_nbr"),
                new Entidade("brscmgmt", "scalable_item", "last_chg_timestamp", string.Empty, string.Empty, "plu_item_nbr", "country_code"),
                new Entidade("brscmgmt", "scalable_item_wc", "last_chg_timestamp", string.Empty, string.Empty, "plu_item_nbr", "country_code"),
                new Entidade("brsprice", "item_est_cost", "last_update_ts", string.Empty, string.Empty, "item_est_cost_id"),
                new Entidade("brsprice", "item_cost_cmpnt", "last_update_ts", string.Empty, string.Empty, "item_est_cost_id", "cost_cmpnt_type_code"),
                new Entidade("brsprice", "pricing_action", "last_change_ts", string.Empty, string.Empty,  "pricing_action_id"),
                new Entidade("brsprice", "price_destination", string.Empty, string.Empty, string.Empty),
                new Entidade("brsamtax", "br_item_tax", "last_change_ts", string.Empty, string.Empty, "item_nbr"),
                new Entidade("brtxrule", "br_tax_ncm", "last_change_ts", string.Empty, string.Empty, "ncm_id"),
                new Entidade("brsamtax", "br_item_tax_prmtr", "last_change_ts", string.Empty, string.Empty, "item_nbr"),
                new Entidade("brsamtax", "br_inbound_ipi", "last_change_ts", string.Empty, string.Empty, "item_nbr", "effective_date"),
                new Entidade("brsamitm", "department_desc", string.Empty, string.Empty, string.Empty),
                new Entidade("brsamitm", "subclass_text", string.Empty, string.Empty, string.Empty),
                new Entidade("brsamitm", "subclass_fnln_text", string.Empty, string.Empty, string.Empty),

                //new Entidade("brsamitm", "upc_item", "last_change_ts", string.Empty, string.Empty, "upc_nbr", "item_nbr"),
                new Entidade("brsamitm", "upc_item", string.Empty, string.Empty, string.Empty, "upc_nbr", "item_nbr"),

                new Entidade("brswc001", "wc_cons_align", string.Empty, string.Empty, string.Empty),
                new Entidade("brsams", "sve_vendor_expense", string.Empty, string.Empty, string.Empty),
                new Entidade("brswcitm", "addl_desc", string.Empty, string.Empty, string.Empty),
                //new Entidade("bromspo", "oms_purchase_order", "last_chg_ts", string.Empty, string.Empty, "oms_po_nbr"),
                //new Entidade("bromspo", "oms_sub_po", "row_change_ts", string.Empty, string.Empty, "oms_sub_order_nbr"),
                //new Entidade("bromspo", "oms_po_line", "row_change_ts", string.Empty, string.Empty, "oms_po_nbr", "oms_po_line_nbr"),
                //new Entidade("bromspo", "oms_sub_po_line", "create_ts", string.Empty, string.Empty, "oms_sub_order_nbr", "oms_sub_line_nbr"),
                new Entidade("brsamitm", "sams_item_alt_sell_uom", "last_update_ts", string.Empty, string.Empty, "item_nbr", "alt_sell_uom_code"),
                new Entidade("brsams", "vendor", "change_date", string.Empty, string.Empty, "vendor_nbr"),
                //new Entidade("brvendor", "v1a_extent", string.Empty, string.Empty, string.Empty),
                new Entidade("brsams", "division", string.Empty, string.Empty, string.Empty),
                new Entidade("brsams", "UOM_TEXT", string.Empty, string.Empty, "And Language_Code = '105'")
            };

#endif

        }


        public string SelectWhereNew(bool loadInicial)
        {
            return !loadInicial && PossuiCampoDataAlteracao
                    ? string.Format(Scripts.SelectWhereNew, CampoDataAlteracao)
                    : string.Empty;
        }

        public string SelectCount(bool loadInicial)
        {
            return string.Format(
                    Scripts.SelectMain,
                    Scripts.SelectCount,
                    Schema,
#if DEBUG
                   Nome == "vendor" ? "vendor_v1" : Nome,
#else

                     Nome,
#endif
                    Join,
                    Filtro,
                    SelectWhereNew(loadInicial));
        }

        public string SelectAll(bool loadInicial)
        {
            return string.Format(
                    Scripts.SelectMain,
                    Scripts.SelectAll,
                    Schema,
#if DEBUG
                   Nome == "vendor" ? "vendor_v1" : Nome,
#else

                     Nome,
#endif
                    Join,
                    Filtro,
                    SelectWhereNew(loadInicial));
        }

        public string SelectPage(bool loadInicial, int maiorQue, int menorIgualQue)
        {
            return string.Format(
                Scripts.SelectPage,
                string.Join(", ", Chaves.ToArray()),
                SelectAll(loadInicial),
                maiorQue,
                menorIgualQue);
        }

        public string Limpar()
        {
            return string.Format(Scripts.Limpar, Nome);
        }

        public string ObterUltimaAlteracao()
        {
            return string.Format(Scripts.UltimaAtualizacaoFormat, CampoDataAlteracao, Nome);
        }

        public string BulkTable()
        {
            return string.Format(Scripts.BulkTable, Nome);
        }

        public string RemoverAntigos()
        {
            StringBuilder filtro = new StringBuilder();
            Chaves.ForEach(c => filtro.AppendFormat(Scripts.RemoverAntigosFiltro, c));
            return string.Format(Scripts.RemoverAntigos, Nome, CampoDataAlteracao, filtro);
        }
    }
}
