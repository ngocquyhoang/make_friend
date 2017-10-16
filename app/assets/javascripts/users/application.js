//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require semantic-ui/dropdown
//= require 'users/dashboard'
//= require 'mouse.parallax'
//= require 'pnotify.min'
//= require semantic_ui/semantic_ui

$(document).ready(function() {
  if ( $( document ).width() >= 992 ) {
    $('#parallaxBackground').mouseParallax({ moveFactor: 7 });
  }
});
