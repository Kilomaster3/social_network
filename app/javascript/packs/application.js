// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
//= require jquery-ui/autocomplete


require('popper.js');
require('bootstrap');
require("jquery-ui");
import '../stylesheets/application.scss'
require("@fortawesome/fontawesome-free");

import '../src/send'
import '../src/map'
import '../src/interest'
import '../src/menu'
import '../src/like'
import '../src/flash'
import '../src/dislike'
import '../src/status'
import '../src/comment'
import '../src/autocomplite'
import '../src/photo'
import $ from 'jquery';
global.$ = jQuery;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
