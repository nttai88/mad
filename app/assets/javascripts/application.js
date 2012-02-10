// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(document).ready(function(){
  Register.init();
  Menu.init();
})
Register = {
  init: function(){
    $("input#user_username").blur(function(){
      var input = $(this);
      $.ajax({
        url: "/users/check_username_availability",
        type: "POST", data: {username: input.val()},
        success: function(data){
          input.parent().find(".error").text(data.message);
        }
      });
    });
  }
}

$('a').click('ajax:complete', function(xhr, status) {
  $(".ajaxful-rating-wrapper").replaceWith(status.responseText)
});

var Menu = {
  init: function(){
    $(".mnu-parent").click(function(){
      $(this).parents("li").find(".mnu-child").toggle();
      return false;
    });
  }
}