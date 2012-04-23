//= require regions
//= require jquery/jquery.corner
//= require refinery/wymeditor
//= require wymeditor/lang/en
//= require wymeditor/skins/refinery/skin
//= require jquery.form
//= require jquery.tools.min
//= require jquery.alerts
//= require slider
//= require menu

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
  projectStatus: null,
  showPublishWarning: false,
  tags: ".field input[type=text], input[type=file], .field textarea.larger.widest, .field textarea.wymeditor, .field select",
  radioValues: {},
  checkboxValues:{},
  init: function(){
    this.initDataValue();
    this.useExistingProfile();
    this.useUploadedAvatar();
    this.initButtons();
    this.initTabs();
    this.initEditTitle();
    this.initPublishWarning();
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
    $(".acc li h3").mouseover(function(){
      if(!$(this).find(".save").is(":visible")){
        $(this).find(".edit").show();
      }
    });
    $(".acc li h3").mouseout(function(){
      $(this).find(".edit").hide();
    });
    $(".acc li h3").click(function(){
      var container = $("#acc");
      if(Project.isDirtyForm(container)){
        container = container.find("h3 .save:visible").parents("li").first();
        Project.showDirtyWarning(container);
        return false;
      }
      return false;
    });
    $(".acc li h3 .edit").click(function(){
      $(this).parents("li").first().find(".acc-section").css("height", "auto").css("opacity", "1");
      $(this).parents("li").first().find(".acc-content .show").hide();
      $(this).parents("li").first().find(".acc-content .edit").show();
      $(this).parents("h3").find(".cancel, .save").show();
      $(this).hide();
      return false;
    });
    $(".acc li h3 .cancel").unbind().click(function(){
      var container = $(this).parents("li").first();
      if(Project.isDirtyForm(container)){
        Project.showDirtyWarning(container);
        return false;
      }
      Project.cancelChanges(container);
      return false;
    });
    $(".acc li h3 .save").unbind().click(function(){
      Project.updateHtmlEditor();
      var container = $(this).parents("li").first();
      Project.saveChanges(container);
      return false;
    });
  },
  initEditTitle: function(){
    $("#title form").submit(function(){
      $("#title a.save").click();
      return false;
    });
    $("#title a.edit").click(function(){
      var container = $(this).parents("#title");
      container.find("div.show").hide();
      container.find("div.edit, a.save, a.cancel").show();
      container.find("#project_title").data("initial_value", container.find("#project_title").val());
      return false;
    });
    $("#title a.cancel").click(function(){
      var container = $(this).parents("#title");
      container.find("div.show").show();
      container.find("div.edit").hide();
      container.find("#project_title").val(container.find("#project_title").data("initial_value"));
      return false;
    });
    $("#title a.save").click(function(){
      var container = $(this).parents("#title");
      Project.saveChanges(container);
      container.find("span.project-title").text(container.find("#project_title").val());
      container.find("#project_title").data("initial_value", container.find("#project_title").val());
      container.find("div.show").show();
      container.find("div.edit").hide();
      return false;
    });
  },
  initPublishWarning: function(){
    $("input[value='to publish']").click(function(){
      if(Project.showPublishWarning && $(this).is(":checked")){
        $.alerts.okButton ='OK';
        $.alerts.cancelButton = 'Cancel';
        $.alerts.confirm('The project is not set to "To publish" by the project owner. Do you want to publish it anyway?', "Warning", function(result){
          if (!result) {
            $("input[value='"+ Project.projectStatus+"']").click()
          }
        });
      }
    })
  },
  cancelChanges: function(container){
    container.find(".acc-content .show").show();
    container.find("h3 .edit, h3 .save, h3 .cancel, .acc-content .edit").hide();
  },
  saveChanges: function(container){
    container.find(".spinner").show();
    container.find("form").ajaxSubmit({
      dataType: 'script',
      success: function(){
        container.find("div.edit, .spinner, a.save, a.cancel").hide();
        container.find("div.show").show();
      }
    });
  },
  rejectChanges: function(container){
    var tags = container.find(Project.tags);
    tags.each(function(){
      $(this).val($(this).data("initial_value"));
      if($(this).hasClass("wymeditor")){
        for(var i = 0; i < WYMeditor.INSTANCES.length; i ++){
          var wym = WYMeditor.INSTANCES[i];
          if($(this).attr("sid") == wym._element.attr("sid")){
            wym.html($(this).val());
          }
        }
      }
    });
    container.find(".field input[type=radio]").each(function(){
      if($(this).val() == Project.radioValues[$(this).attr("name")]){
        $(this).attr("checked", "checked");
      }
    })
    container.find(".field input[type=checkbox]").each(function(){
      $(this).attr("checked", Project.checkboxValues[$(this).attr("name")]);
    })
  },
  updateHtmlEditor: function(index){
    for(var i = 0; i < WYMeditor.INSTANCES.length; i ++){
      WYMeditor.INSTANCES[i].update();
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
  isDirtyForm: function(container){
    Project.updateHtmlEditor();
    if(!container){container = $("#acc")};
    var tags = container.find(Project.tags);
    for(var i = 0; i < tags.length; i ++){
      var t = $(tags[i]);
      if($.type(t.val) == "array" || $.type(t.data("initial_value")) == "array"){
        if(t.val().toString() != t.data("initial_value").toString()){
          return true;
        }
      }else if(t.val() != t.data("initial_value")){
        return true;
      }
    }
    var radioTags = container.find(".field input[type=radio]:checked");
    for(var j = 0; j < radioTags.length; j ++){
      var e = $(radioTags[j]);
      if(e.val() != Project.radioValues[e.attr("name")]){
        return true;
      }
    }
    var checkboxTags = container.find(".field input[type=checkbox]");
    for(var k = 0; k < checkboxTags.length; k ++){
      var el = $(checkboxTags[k]);
      if(el.is(":checked") != Project.checkboxValues[el.attr("name")]){
        return true;
      }
    }
    return false;
  },
  showDirtyWarning: function(container){
    $.alerts.okButton ='Save';
    $.alerts.cancelButton = 'Discard Changes';
    $.alerts.confirm("Please save or discard your changes to continue", "You have unsaved changes", function(result){
      if (result) {
        Project.saveChanges(container);
      }else {
        Project.rejectChanges(container);
        Project.cancelChanges(container);
      }
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
    $(".new-attachment").unbind().click(function(){
      $(".new_attachments").show();
      var trs = $(".new_attachments tr");
      for(var i = 0; i < trs.length; i ++){
        var tr = $(trs[i]);
        if(tr.is(":visible") == false){
          tr.show();
          if ($(".new_attachments tr:visible").length == Attachment.numOfAttachments){
            $(".new-attachment").hide();
          }else{
            $(".new-attachment").show();
          }
          Attachment.displayAttachLink();
          return false;
        }
      }
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