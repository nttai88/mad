//= require regions
//= require i18n-messages
//= require jquery/jquery.corner
//= require refinery/wymeditor

iframed = function() {
  return (parent && parent.document && parent.document.location.href != document.location.href && $.isFunction(parent.$));
};


$(document).ready(function(){
  Project.init();
})
Project = {
  init: function(){
    $("#project_use_user_avatar").click(function(){
      if($(this).is(":checked")){
        $("input.upload-avatar").hide();
      }else{
        $("input.upload-avatar").show();
      }
      
    });
  }
}