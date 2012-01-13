Refinery::SessionsController.class_eval do
  before_filter :find_pages_for_menu
  layout "application"
  before_filter :force_ssl
end
