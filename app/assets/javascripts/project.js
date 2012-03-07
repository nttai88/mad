//= require regions
//= require i18n-messages
//= require jquery/jquery.corner
//= require refinery/wymeditor
//= require wymeditor/lang/en
//= require wymeditor/skins/refinery/skin
//= require jquery.form
//= require jquery.tools.min
//= require jquery.alerts
//= require script

iframed = function() {
  return (parent && parent.document && parent.document.location.href != document.location.href && $.isFunction(parent.$));
};

$(document).ready(function(){
  Project.init();
  Attachment.init();
})

Project = {
  checkDirty: false,
  tabs: null,
  tags: ".field input[type=text], input[type=file], .field textarea.larger.widest, .field textarea.wymeditor, .field select",
  radioValues: {},
  checkboxValues:{},
  init: function(){
    this.initDataValue();
    this.useExistingProfile();
    this.useUploadedAvatar();
    this.initButtons();
    this.initTabs();
  },
  initDataValue: function(){
    $(Project.tags).each(function(){
      $(this).data("initial_value", $(this).val());
    });
    $(".field input[type=radio]:checked").each(function(){
      Project.radioValues[$(this).attr("name")] = $(this).val();
    });
    $(".field input[type=checkbox]").each(function(){
      Project.checkboxValues[$(this).attr("name")] = $(this).is(":checked");
    });
  },
  initButtons: function(){
    $(".actions .next").unbind().click(function(){
      Project.updateHtmlEditor();
      if(Project.isDirtyForm()){
        Project.showDirtyWarning("next");
        return false;
      }
      Project.tabs.next();
      $(this).blur()
      Project.showHideNextPrevButtons();
    });
    $(".actions .save").unbind().click(function(){
      Project.updateHtmlEditor();
      Project.saveChanges(null);
    });
    $(".actions .prev").unbind().click(function(){
      Project.updateHtmlEditor();
      if(Project.isDirtyForm()){
        Project.showDirtyWarning("prev");
        return false;
      }
      Project.tabs.prev();
      $(this).blur()
      Project.showHideNextPrevButtons();
    });

    $(".alt-tools .exit").click(function(){
      if(Project.isDirtyForm()){
        Project.showDirtyWarning(null);
        return false;
      }
      return true;
    });
  },
  saveChanges: function(action){
    $(".actions .spinner").show();
    Project.tabs.getCurrentPane().find("form").ajaxSubmit({
      dataType: 'script',
      success: function(){
        $(".actions .spinner").hide();
        $(".actions .save").blur();
        Project.nextPrev(action);
      }
    });
  },
  rejectChanges: function(){
    var form = Project.tabs.getCurrentPane().find("form");
    var tags = form.find(Project.tags);
    tags.each(function(){
      $(this).val($(this).data("initial_value"));
      if($(this).hasClass("wymeditor")){
        try{
        wym.html($(this).val());
        }catch(ex){}
      }
    });
    form.find(".field input[type=radio]").each(function(){
      if($(this).val() == Project.radioValues[$(this).attr("name")]){
        $(this).attr("checked", "checked");
      }
    })
    form.find(".field input[type=checkbox]").each(function(){
      $(this).attr("checked", Project.checkboxValues[$(this).attr("name")]);
    })
  },
  updateHtmlEditor: function(){
    try{
      wym.update();
    }catch(ex){}
  },
  showHideNextPrevButtons: function(){
    if(Project.tabs){
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
    $("#tab-menu ul").tabs("#tab-panes > div",{
      initialIndex: 0,
      current: "active"
    });
    this.tabs = $("#tab-menu ul").data("tabs");
    $("#tab-menu ul li a").click(function(){
      $(this).blur();
    });
  },
  isDirtyForm: function(){
    if(Project.tabs){
      var form = Project.tabs.getCurrentPane().find("form");
      var tags = form.find(Project.tags);
      for(var i = 0; i < tags.length; i ++){
        var t = $(tags[i]);
        if($.type(t.val) == "array"){
          if(t.val().toString() != t.data("initial_value").toString()){
            return true;
          }
        }else if(t.val() != t.data("initial_value")){
          return true;
        }
      }
      var radioTags = form.find(".field input[type=radio]:checked");
      for(var j = 0; j < radioTags.length; j ++){
        var e = $(radioTags[j]);
        if(e.val() != Project.radioValues[e.attr("name")]){
          return true;
        }
      }
      var checkboxTags = form.find(".field input[type=checkbox]");
      for(var k = 0; k < checkboxTags.length; k ++){
        var el = $(checkboxTags[k]);
        if(el.is(":checked") != Project.checkboxValues[el.attr("name")]){
          return true;
        }
      }
      return false;
    }else{
      return true;
    }
  },
  showDirtyWarning: function(action){
    $.alerts.okButton ='Save';
    $.alerts.cancelButton = 'Discard Changes';
    $.alerts.confirm("Please save or discard your changes to continue", "You have unsaved changes", function(result){
      if (result) {
        Project.saveChanges(action);
      }else {
        Project.rejectChanges();
        Project.nextPrev(action)
      }
      Project.showHideNextPrevButtons();
    });
  },
  nextPrev: function(action){
    if(action == "next"){
      Project.tabs.next();
    }else if(action == "prev"){
      Project.tabs.prev();
    }
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