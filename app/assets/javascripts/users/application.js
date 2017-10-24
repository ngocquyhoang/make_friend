//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require 'users/dashboard'
//= require 'mouse.parallax'
//= require 'pnotify.min'
//= require semantic-ui 

$(document).ready(function() {
  if ( $( document ).width() >= 992 ) {
    $('#parallaxBackground').mouseParallax({ moveFactor: 7 });
  }
});
