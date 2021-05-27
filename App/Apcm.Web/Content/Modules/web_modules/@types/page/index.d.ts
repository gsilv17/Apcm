declare function Page_ClientValidate(): void;

declare let Page_IsValid: boolean;

declare interface HTMLValidateElement extends HTMLElement {
    Validators: Array<HTMLValidateElement>;
    isvalid: boolean;
}
