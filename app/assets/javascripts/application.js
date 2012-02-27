// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery_ui
//= require refinery/core
// require foundation
// require_tree .

$(document).ready(function(){
  Register.init();
  Menu.init();
  Attachment.init();
})
Register = {
  init: function(){
    $("input#user_username").blur(function(){
      var input = $(this);
      var container = input.parents(".field");
      $.ajax({ url: "/users/check_username_availability",
        type: "POST", data: {username: input.val()},
        success: function(data){
          container.find("span.error, span.notice").hide();
          if(data.status == true){
            container.find(".notice").text(data.message).show();
          }else{
            container.find(".error").text(data.message).show();
          }
        }
      });
    }).keydown(function(){
      var spans = $(this).parents(".field").find("span.error, span.notice");
      spans.text("");
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

var Attachment = {
  numOfAttachments: null,
  init: function(){
    $(".new_attachments").hide();
    Attachment.numOfAttachments = $(".new_attachments tr").length;
    Attachment.displayAttachLink();
    Attachment.bindRemoveAction();
    Attachment.bindNewAction();
  },
  bindNewAction: function(){
    $(".new-attachment").click(function(){
      $(".new_attachments").show();
      $(".new_attachments tr").each(function(){
        if($(this).is(":visible") == false){
          $(this).show();
          if ($(".new_attachments tr:visible").length == Attachment.numOfAttachments){
            $(".new-attachment").hide();
          }else{
            $(".new-attachment").show();
          }
          Attachment.displayAttachLink();
          return false;
        }
      });
      return false;
    });
  },
  bindRemoveAction: function(){
    $(".new_attachments .remove").click(function(){
      $(this).parents("tr").hide().find("input").val("");
      if($(".new_attachments tr:visible").length == $(".new_attachments tr").length){
        $(".new-attachment").hide();
      }else{
        $(".new-attachment").show();
      }
      if ($(".new_attachments tr:visible").length == 0){
        $(".new_attachments").hide();
      } 
      return false;
    });
    var url = window.location.href;
    var hash = url.substring(url.indexOf("#")+1);
    if(hash == "attachments"){
      $('.partial_profile').hide();$('#attachment').show(); return false;
    }
  },
  displayAttachLink: function(){
    if (Attachment.numOfAttachments == 10 && $(".new_attachments tr:visible").length == 0){
      $(".new-attachment").text("Attach a file");
    }else{
      $(".new-attachment").text("Attach another file");
    }
  }
}