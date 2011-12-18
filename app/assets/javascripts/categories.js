$(document).ready(function(){
  Category.bindNew();
  Category.bindDelete();
});

var Category = {
  bindNew: function(){
    $('.new-category').bind('click', function(){
      var template = $(".template").html();
      $(".new-categories").append(template);
      $(".submit").show();
      Category.bindDelete();
      return false;
    });
  },
  bindDelete: function(){
    $(".delete-new-category").unbind().click(function(){
      $(this).parents(".category").first().remove();
      if($(".new-categories .category").length == 0){
        $(".submit").hide();
      }
      return false
    });
  }
}