$(function () {
    document.querySelectorAll(".custom-file-label").forEach((label) => {
        let input = document.querySelector("#" + label.htmlFor);
        let importar = document.querySelector("#" + $(input).attr("aria-describedby"));
        input.onchange = () => {
            let file = input.files[0];
            label.innerText = file ? file.name : "Selecione um arquivo...";
            if (file) {
                importar.click();
            }
        };
    });
});
export {};
//# sourceMappingURL=NovosProdutos.js.map