import UpdatePanelService from "./UpdatePanelService.js";
export default class ModalEsperaService {
    constructor() { }
    /**
     * Registra a abertura da modal de espera no evento click de elementos com a classe 'ts-modal-espera-click',
     * Quando existe Update Panel também registra a abertura e fechamento nos eventos BeginRequest e EndRequest.
     * */
    static RegistrarAcoes() {
        this.RegistrarModalEsperaClick();
        UpdatePanelService.AddBeginRequest(this.Abrir);
        UpdatePanelService.AddEndRequest(this.Fechar);
    }
    static RegistrarModalEsperaClick() {
        $(".ts-modal-espera-click").click(this.Abrir);
    }
    static Abrir() {
        document.querySelectorAll(".ts-modal-espera").forEach((div) => div.classList.add("show"));
    }
    static Fechar() {
        document.querySelectorAll(".ts-modal-espera").forEach((div) => div.classList.remove("show"));
    }
}
//# sourceMappingURL=ModalEsperaService.js.map