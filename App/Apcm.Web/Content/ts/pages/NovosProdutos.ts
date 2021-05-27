import InputService from "../services/InputService.js";

$(function () {

    document.querySelectorAll<HTMLLabelElement>(".custom-file-label").forEach((label) => {
        let input = document.querySelector<HTMLInputElement>("#" + label.htmlFor);
        let importar = document.querySelector<HTMLButtonElement>("#" + $(input).attr("aria-describedby"));
        input.onchange = () => {
            let file = input.files[0];
            label.innerText = file ? file.name : "Selecione um arquivo...";
            if (file) {
                importar.click();
            }
        };
    });
});