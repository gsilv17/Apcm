import UpdatePanelService from "./UpdatePanelService.js";
export default class InputService {
    constructor() { }
    /**
     * Registra a correta apresentação do nome do arquivo selecionado
     * no label correspondente.
     * Utilizar em páginas sem Update Panel, após carregamento.
     */
    static RegistrarInputFile_Change() {
        document.querySelectorAll(".custom-file-label").forEach((label) => {
            let input = document.querySelector("#" + label.htmlFor);
            input.onchange = () => InputService.InputFile_Change(label, input);
        });
    }
    static InputFile_Change(label, input) {
        let file = input.files[0];
        label.innerText = file ? file.name : "Selecione um arquivo...";
    }
    /**
     * Registra inputs como datepicker para campos com os seguintes estilos:
     * ts-input-datepicker em caixas de texto, ts-input-datepicker input-daterange em div input-group (bootstrap) com duas caixas de texto.
     * Mais detalhes em https://bootstrap-datepicker.readthedocs.io/en/v1.9.0/ ou verifique a lib bootstrap-datepicker
     * */
    static RegistrarDatepicker() {
        let registro = () => {
            $(".ts-input-datepicker").datepicker({
                language: "pt-BR",
                autoclose: true,
                todayBtn: "linked"
            });
        };
        registro();
        UpdatePanelService.AddEndRequest(registro);
    }
    /**
     * Registra inputs numéricos para campos com os seguintes estilos:
     * ts-input-numerico, ts-input-telefone, ts-input-decimal e ts-input-cpf.
     * */
    static RegistrarInputsNumericos() {
        let registro = () => {
            document.querySelectorAll(".ts-input-numerico").forEach((input) => {
                input.onkeydown = (KeyboardEvent) => this.keyDownNumerico(KeyboardEvent);
                input.onpaste = (ClipboardEvent) => {
                    input.value = this.pasteNumber(ClipboardEvent, input.maxLength);
                };
            });
            document.querySelectorAll(".ts-input-telefone").forEach((input) => {
                input.onkeydown = (KeyboardEvent) => this.keyDownTelefone(KeyboardEvent);
                input.onpaste = (ClipboardEvent) => {
                    input.value = this.pasteTelefone(ClipboardEvent);
                };
            });
            document.querySelectorAll(".ts-input-decimal").forEach((input) => {
                input.onkeydown = (KeyboardEvent) => this.keyDownDecimal(KeyboardEvent);
                input.onpaste = (ClipboardEvent) => {
                    input.value = this.pasteDecimal(ClipboardEvent, input.maxLength);
                };
            });
            document.querySelectorAll(".ts-input-cpf").forEach((input) => {
                input.onkeydown = (KeyboardEvent) => this.keyDownCpf(KeyboardEvent);
            });
        };
        registro();
        UpdatePanelService.AddEndRequest(registro);
    }
    /**
     * Permite a cola de somente números.
     * @param event Evento Paste.
     * @param maxlength Número máximo de caracteres.
     */
    static pasteNumber(event, maxlength) {
        event.preventDefault();
        return event.clipboardData.getData('text/plain').replace(/\D/g, "").substring(0, maxlength);
    }
    /**
     * Permite a cola somente de valores decimais (digitos, pontos e vírgulas).
     * @param event Evento Paste.
     * @param maxlength Número máximo de caracteres.
     */
    static pasteDecimal(event, maxlength) {
        event.preventDefault();
        return event.clipboardData.getData('text/plain').replace(/[^\d|\,|\.]/g, '').substring(0, maxlength);
    }
    /**
     * Permite a cola somente de valores para compor um número de telefone (digitos, espaços, traços e parênteses).
     * @param event Evento Paste.
     */
    static pasteTelefone(event) {
        event.preventDefault();
        return event.clipboardData.getData('text/plain').replace(/[^\(\)\ \-\d]/, "").substring(0, 16);
    }
    /**
     * Retorna o elemento input a partir do evento de teclado.
     * @param event Evento de teclado.
     */
    static getHTMLInputElement(event) {
        return event.currentTarget;
    }
    /**
     * Verifica se o evento está em uma relação de combinação de taclas.
     * Retorna se o evento está coberto pela relação informada.
     * @param event Evento Keyboard.
     * @param keyCodeSet Relação de combinação de teclas.
     */
    static isKeyCode(event, keyCodeSet) {
        return keyCodeSet.some(k => {
            if (k.invariantCtrlShift || false) {
                k.shift = event.shiftKey;
                k.ctrl = event.ctrlKey;
            }
            return k.keyCodes.some(keyCode => event.keyCode == keyCode)
                && event.shiftKey == (k.shift || false)
                && event.ctrlKey == (k.ctrl || false);
        });
    }
    /**
     * Permite KeyDown Decimal (Teclas de controle + CTRL (A, C, V, X, Z) + Números + Vírgula + Ponto).
     * Bloqueia KeyDown não Decimal.
     * Retorna permissão de KeyDown, true para permitido, false para bloqueado.
     * @param event evento KeyDown.
     */
    static keyDownDecimal(event) {
        if (this.isKeyCode(event, [
            { keyCodes: this.decimalKeyCodes() },
            { keyCodes: this.acvxzKeyCodes(), ctrl: true },
            { keyCodes: this.controlKeyCodes(), invariantCtrlShift: true }
        ])) {
            return true;
        }
        else {
            event.preventDefault();
            return false;
        }
    }
    /**
     * Permite KeyDown CPF (Teclas de controle + CTRL (A, C, V, X, Z) + Números + Traço + Ponto).
     * Bloqueia KeyDown não CPF.
     * Retorna permissão de KeyDown, true para permitido, false para bloqueado.
     * @param event evento KeyDown.
     */
    static keyDownCpf(event) {
        if (this.isKeyCode(event, [
            { keyCodes: this.cpfKeyCodes() },
            { keyCodes: this.acvxzKeyCodes(), ctrl: true },
            { keyCodes: this.controlKeyCodes(), invariantCtrlShift: true }
        ])) {
            return true;
        }
        else {
            event.preventDefault();
            return false;
        }
    }
    /**
     * Permite KeyDown numérico (Teclas de controle + CTRL (A, C, V, X, Z) + Números).
     * Bloqueia KeyDown não numérico.
     * Retorna permissão de KeyDown, true para permitido, false para bloqueado.
     * @param event evento KeyDown.
     */
    static keyDownNumerico(event) {
        if (this.isKeyCode(event, [
            { keyCodes: this.numberKeyCodes() },
            { keyCodes: this.acvxzKeyCodes(), ctrl: true },
            { keyCodes: this.controlKeyCodes(), invariantCtrlShift: true }
        ])) {
            return true;
        }
        else {
            event.preventDefault();
            return false;
        }
    }
    /**
     * Permite KeyDown para telefone (Teclas de controle + CTRL (A, C, V, X, Z) + Números + Espaço + Parênteses + Traço).
     * Bloqueia KeyDown não telefonico.
     * Retorna permissão de KeyDown, true para permitido, false para bloqueado.
     * @param event evento KeyDown.
     */
    static keyDownTelefone(event) {
        if (this.isKeyCode(event, [
            { keyCodes: this.telefoneKeyCodes() },
            { keyCodes: this.parentesesKeyCodes(), shift: true },
            { keyCodes: this.acvxzKeyCodes(), ctrl: true },
            { keyCodes: this.controlKeyCodes(), invariantCtrlShift: true }
        ])) {
            return true;
        }
        else {
            event.preventDefault();
            return false;
        }
    }
    /**
     * Permite KeyDown para teclas de controle sem edição.
     * Retorna permissão de KeyDown, true para permitido, false para bloqueado.
     * @param event evento KeyDown.
     */
    static keyDownLockEdit(event) {
        if (this.isKeyCode(event, [
            { keyCodes: this.lockEditKeyCodes(), invariantCtrlShift: true }
        ])) {
            return true;
        }
        else {
            event.preventDefault();
            return false;
        }
    }
    /**
     * KeyCodes numéricos.
     */
    static numberKeyCodes() {
        return [
            48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
            96, 97, 98, 99, 100, 101, 102, 103, 104, 105, // Digitos (teclado numérico)
        ];
    }
    /**
     * KeyCodes de teclas de controle.
     */
    static controlKeyCodes() {
        let editKeyCodes = [8, 46]; // Backspace e Delete.
        return this.lockEditKeyCodes().concat(editKeyCodes);
    }
    /**
     * Keycodes de teclas de controle, sem edição.
     */
    static lockEditKeyCodes() {
        return [
            9, 13, 20, 27,
            37, 38, 39, 40,
            33, 34, 35, 36,
            144,
            112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123 // F(x)
        ];
    }
    /**
     * KeyCodes para vírgula.
     */
    static virgulaKeyCodes() {
        return [
            110, 188 // Vírgulas
        ];
    }
    /**
     * KeyCodes para ponto.
     */
    static pontoKeyCodes() {
        return [
            190, 194 // Pontos
        ];
    }
    /**
     * KeyCodes para traço.
     */
    static tracoKeyCodes() {
        return [
            109, 189 // Traços
        ];
    }
    /**
     * KeyCodes para a, c, v, x, z.
     * Obs.: Utilizar com CTRL.
     */
    static acvxzKeyCodes() {
        return [
            65, 67, 86, 88, 90 // acvxz
        ];
    }
    /**
     * Keycodes para Espaço.
     */
    static espacoKeyCodes() {
        return [
            32
        ];
    }
    /**
     * Keycodes para parênteses.
     * Obs.: utilizar com SHIFT.
     */
    static parentesesKeyCodes() {
        return [
            57, 48
        ];
    }
    /**
     * Keycodes para decimal.
     * Inclui: Teclas numéricas, virgula e ponto.
     */
    static decimalKeyCodes() {
        return this.numberKeyCodes().concat(this.virgulaKeyCodes(), this.pontoKeyCodes());
    }
    /**
     * Keycodes para telefone.
     * Inclui: Teclas numéricas, Parênteses, espaço e traço.
     */
    static telefoneKeyCodes() {
        return this.numberKeyCodes().concat(this.espacoKeyCodes(), this.tracoKeyCodes());
    }
    /**
     * Keycodes para CPF.
     * Inclui: Teclas numéricas, ponto e traço. (9.-)
     */
    static cpfKeyCodes() {
        return this.numberKeyCodes().concat(this.pontoKeyCodes(), this.tracoKeyCodes());
    }
}
//# sourceMappingURL=InputService.js.map