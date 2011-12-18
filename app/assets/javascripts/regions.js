$(document).ready(function(){
  Region.bindNew();
  Region.bindDelete();
});

var Region = {
  bindContrySelect: function(){
    $(".country").unbind().bind("change", function(){
      var country = $(this).val();
      var state = $(this).parents(".region").first().find(".state");
      var options = states[country];
      state.html(options);
    });
  },
  bindNew: function(){
    $('.new-region').bind('click', function(){
      var template = $(".region-template").html();
      $(".regions").append(template);
      $(".submit").show();
      Region.bindDelete();
      Region.bindContrySelect();
      return false;
    });
  },
  bindDelete: function(){
    $(".delete-region").unbind().click(function(){
      $(this).parents(".region").first().remove();
      if($(".regions .region").length == 0){
        //$(".submit").hide();
      }
      return false
    });
  }
}