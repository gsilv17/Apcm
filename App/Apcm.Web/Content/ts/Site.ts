/// <reference path="../modules/node_modules/@types/jquery/index.d.ts" />
/// <reference path="../modules/node_modules/@types/bootstrap/index.d.ts" />
/// <reference path="../modules/node_modules/@types/microsoft-ajax/index.d.ts" />
/// <reference path="../modules/node_modules/@types/bootstrap-datepicker/index.d.ts" />
/// <reference path="../modules/web_modules/@types/page/index.d.ts" />

import ModalEsperaService from "./services/ModalEsperaService.js";

$(function () {
    ModalEsperaService.RegistrarAcoes();
});