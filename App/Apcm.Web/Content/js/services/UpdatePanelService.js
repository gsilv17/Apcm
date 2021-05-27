export default class UpdatePanelService {
    constructor() { }
    /**
     * Verifica a existência do controle Sys.WebForms.PageRequestManager (Microsoft.Ajax).
     * */
    static HasPageRequestManager() {
        let pageRequestManager = Sys.WebForms.PageRequestManager.getInstance();
        return pageRequestManager != null;
    }
    /**
     * Registra um método para execução no evento Begin Request de Update Panel.
     * @param fnBeginRequest: Método para execução.
     */
    static AddBeginRequest(fnBeginRequest) {
        let pageRequestManager = Sys.WebForms.PageRequestManager.getInstance();
        if (pageRequestManager != null) {
            pageRequestManager.add_beginRequest(fnBeginRequest);
        }
    }
    /**
     * Registra um método para execução no evento End Request de Update Panel.
     * @param fnEndRequest: Método para execução.
     */
    static AddEndRequest(fnEndRequest) {
        let pageRequestManager = Sys.WebForms.PageRequestManager.getInstance();
        if (pageRequestManager != null) {
            pageRequestManager.add_endRequest(fnEndRequest);
        }
    }
}
//# sourceMappingURL=UpdatePanelService.js.map