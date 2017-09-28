// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require social-share-button
//= require moment
//= require bootstrap-datetimepicker
//= require_tree .


function getGeoLocation() {
  navigator.geolocation.getCurrentPosition(setGeoCookie);
}

function setGeoCookie(position) {
  var expiration = new Date();
        expiration.setTime(expiration.getTime()+(10*60*100));
  var cookie_val = position.coords.latitude + "_" + position.coords.longitude;
  console.log(cookie_val)
  document.cookie = "lat_lng=" + escape(cookie_val) + "; expires=" + expiration.toGMTString();
}
