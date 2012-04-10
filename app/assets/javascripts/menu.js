var Menu = {
  init: function(){
    $(".mnu-parent").click(function(){
      $(this).blur();
      $(this).parents("li").find(".mnu-child").toggle();
      return false;
    });
  }
}