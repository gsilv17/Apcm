import UpdatePanelService from "./UpdatePanelService.js";

export default class ModalEsperaService {

    constructor() { }

    /**
     * Registra a abertura da modal de espera no evento click de elementos com a classe 'ts-modal-espera-click',
     * Quando existe Update Panel também registra a abertura e fechamento nos eventos BeginRequest e EndRequest.
     * */
    static RegistrarAcoes(): void {
        this.RegistrarModalEsperaClick();
        UpdatePanelService.AddBeginRequest(this.Abrir);
        UpdatePanelService.AddEndRequest(this.Fechar);
    }

    private static RegistrarModalEsperaClick() {
        $(".ts-modal-espera-click").click(this.Abrir);
    }

    private static Abrir(): void {
        document.querySelectorAll<HTMLDivElement>(".ts-modal-espera").forEach((div) => div.classList.add("show"));
    }

    private static Fechar(): void {
        document.querySelectorAll<HTMLDivElement>(".ts-modal-espera").forEach((div) => div.classList.remove("show"));
    }
}