//= require regions
//= require i18n-messages
//= require jquery/jquery.corner
//= require refinery/wymeditor
//= require wymeditor/lang/en
//= require wymeditor/skins/refinery/skin
//= require jquery.form
//= require jquery.tools.min

iframed = function() {
  return (parent && parent.document && parent.document.location.href != document.location.href && $.isFunction(parent.$));
};

$(document).ready(function(){
  Project.init();
})

Project = {
  projectUrl: null,
  init: function(){
    this.projectUrl = $("#project-form").attr("action");
    this.initTabs();
    this.autoSave();
    this.useExistingProfile();
    this.useUploadedAvatar();
  },
  autoSave: function(){
    $(".field input[type=text], .field textarea").each(function(){
      $(this).data("initial_value",$(this).val());
    });
    $(".field input[type=text], .field textarea").blur(function(){
      var input = $(this);
      if(input.val() != input.data('initial_value')){
        var data = {};
        data[$(this).attr("name")] = $(this).val();
        $.ajax({
          type: 'POST', url: Project.projectUrl,
          data: data, dataType: "json",
          success: function(data){
            input.data("initial_value",input.val());
          }
        });
      }
    });
  },
  useUploadedAvatar: function(){
    $("#project_use_user_avatar").click(function(){
      if($(this).is(":checked")){
        $("input.upload-avatar").hide();
      }else{
        $("input.upload-avatar").show();
      }
    });
  },
  useExistingProfile: function(){
    $("#use_existing").click(function() {
      if ($(this).is(":checked")) {
        $("#project_name").val($(this).data("user").full_name);
        $("#project_contact_attributes_address1").val($(this).data("user").address1);
        $("#project_contact_attributes_address2").val($(this).data("user").address2);
        $("#project_contact_attributes_city").val($(this).data("user").city);
        $("#project_contact_attributes_zip").val($(this).data("user").zip);
        $("#project_contact_attributes_phone").val($(this).data("user").phone);
        $("#project_contact_attributes_about").val($(this).data("user").about);
        $("#project_external_url").val($(this).data("user").url);
      } else {
        $.each(["#project_name", "#project_contact_attributes_zip", "#project_contact_attributes_city",
        "#project_contact_attributes_phone", "#project_contact_attributes_address1",
        "#project_contact_attributes_address2", "#project_contact_attributes_about",
        "#project_external_url"], function(idx, value) {
          $(value).val("");
        });
      }
    });
  },
  initTabs: function(){
    $("ul#tab-headers").tabs("div#tab-panes > div",{
      initialIndex: 0,
      onClick: function(event, tabIndex) {
        return false;
      }
    });
  }
}
