//= require jquery
//= require jquery_ujs
//= require 'users/dashboard'
//= require 'mouse.parallax'
//= require 'pnotify.min'

$(document).ready(function() {
  if ( $( document ).width() >= 992 ) {
    $('#parallaxBackground').mouseParallax({ moveFactor: 7 });
  }
});
