//= require regions
//= require i18n-messages
//= require jquery/jquery.corner
//= require refinery/wymeditor

iframed = function() {
  return (parent && parent.document && parent.document.location.href != document.location.href && $.isFunction(parent.$));
};
