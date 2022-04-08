// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('admin-lte')
require('datatables.net-bs4')
require('datatables.net-buttons')
require('datatables.net-buttons-bs4')
require('jszip')
require( 'datatables.net-buttons')


import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
import '../stylesheets/application.scss'
import "@fortawesome/fontawesome-free/css/all.css"
import 'select2'
import '../stylesheets/dropify.min.css'
import './dropify.min.js'


Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", () => {
    $('[data-toggle="tooltip"]').tooltip();
});

global.toastr = require("toastr")

$(document).ready(function() {
    $('.select2').select2();
});

// Jquery
import jquery from 'jquery';

window.$ = window.jquery = jquery;
window.jQuery = window.jquery = jquery;


//Theme
require('admin-lte');
require.context('admin-lte/dist/img', true);

// Common Lib
import 'bootstrap';
import '@fortawesome/fontawesome-free/js/all';
global.toastr = require('toastr');
global.bootbox = require('bootbox');
global.moment = require('moment');
require('inputmask');
require('select2');
require('bootstrap-datepicker');
require('bootstrap-timepicker');
require('bootstrap-slider');

// AngularJs
global.angular = require('angular');
require('angular-route');
require('packs/base/init');
require('packs/base/angular_app');
require('packs/base/angular_utils');
require('packs/lib/combodate');

// AngularJs Controllers
global.app = angular.module('app');
require("packs/pages/admin_users_ctrl");