$(document).ready(function(){
  Region.bindNew();
  Region.bindDelete();
  Region.bindContrySelect();
});

var Region = {
  bindContrySelect: function(){
    $(".country").unbind().bind("change", function(){
      var country = $(this).val();
      var state = $(this).parents(".region").first().find("select.state");
      var options = states[country];
      if(options == ""){
        $(this).parents(".region").first().find(".state").hide();
      }else{
        $(this).parents(".region").first().find(".state").show();
      }
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