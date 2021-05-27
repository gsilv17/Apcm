import PageService from "./PageService";

export default class ValidationService {

    constructor() { }

    /**
     * Registra a formatação de destaque de validação nos campos.
     * Os campos devem possuir a classe ts-destaque-validacao, receberão as classes, de acordo com a validação, serão revalidados quando alterados.
     * O botão submit deve possui a classe ts-destaque-validacao-submit, receberá a classe btn-success ou btn-danger, de acordo com a validação de toda a página.
     * O botão ficará inativo quando a validação da página for inválida. 
     * @param validacaoInicial Indica se deverá ocorrer uma validação imediata na página.
     */
    static RegistrarDestaqueValidacao(validacaoInicial: boolean): void {
        if (validacaoInicial) {
            PageService.ValidarPagina();
            $.each($(".ts-destaque-validacao"), (index, value) => this.DestacarValidacao(value as HTMLValidateElement));
        }
                
        $(".ts-destaque-validacao").change(event => this.DestacarValidacao(event.target as HTMLValidateElement));
    }
    
    private static DestacarValidacao(control: HTMLValidateElement) {
        let isvalid = true;
        control.Validators.forEach(validator => {
            if (!validator.isvalid) {
                isvalid = false;
            }
        });

        $(control).removeClass("success");
        $(control).removeClass("danger");
        $(control).addClass(isvalid ? "success" : "danger");

        this.DestacarValidacaoSubmit($('.ts-destaque-validacao-submit'));
    }

    private static DestacarValidacaoSubmit(control: JQuery<HTMLElement>) {
        $(control).prop("disabled", !Page_IsValid);
        $(control).removeClass("btn-success");
        $(control).removeClass("btn-danger");
        $(control).addClass(Page_IsValid ? "btn-success" : "btn-danger");
    }
}