export default class PageService {

    constructor() { }

    /** Realiza a validação WebForms dos campos da página */
    static ValidarPagina(): void {
        Page_ClientValidate();
    }
}