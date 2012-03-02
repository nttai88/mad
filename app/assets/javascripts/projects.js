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
  Attachment.init();
})

Project = {
  tabs: null,
  init: function(){
    this.initTabs();
    this.useExistingProfile();
    this.useUploadedAvatar();
    this.initButtons();
  },
  initButtons: function(){
    $(".actions .next").unbind().click(function(){
      Project.tabs.next();
      $(this).blur()
      Project.showHideNextPrevButtons();
    });
    $(".actions .save").unbind().click(function(){
      $(".actions .spinner").show();
      Project.updateHtmlEditor();
      Project.tabs.getCurrentPane().find("form").ajaxSubmit({
        dataType: 'script',
        success: function(){
          $(".actions .spinner").hide();
          $(".actions .save").blur();
        }
      });
    });
    $(".actions .prev").unbind().click(function(){
      Project.tabs.prev();
      $(this).blur()
      Project.showHideNextPrevButtons();
    });
  },
  updateHtmlEditor: function(){
    var currentPane = Project.tabs.getCurrentPane();
    if(currentPane.find("iframe").length > 0){
      var html = currentPane.find("iframe").contents().find("body").html();
      currentPane.find("textarea.wymeditor").val(html);
    }
  },
  showHideNextPrevButtons: function(){
    if(Project.tabs){
      Project.updateHtmlEditor();
      var length = Project.tabs.getTabs().length -1;
      if(Project.tabs.getIndex() == length){
       $(".actions .next").hide();
      }else{
        $(".actions .next").show();
      }
      if(Project.tabs.getIndex() == 0){
        $(".actions .prev").hide();
      }else{
        $(".actions .prev").show();
      }
    }
  },
  useUploadedAvatar: function(){
    $("#project_use_user_avatar").unbind().click(function(){
      if($(this).is(":checked")){
        $("input.upload-avatar").hide();
      }else{
        $("input.upload-avatar").show();
      }
    });
  },
  useExistingProfile: function(){
    $("#use_existing").unbind().click(function() {
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
        Project.showHideNextPrevButtons();
        return false;
      }
    });
    this.tabs = $("ul#tab-headers").data("tabs");
    $(".actions .prev").hide();
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
    $(".new-attachment").unbind().click(function(){
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
    $(".new_attachments .remove").unbind().click(function(){
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