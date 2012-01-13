Refinery::PasswordsController.class_eval do
  before_filter :find_pages_for_menu
  before_filter :force_ssl
  layout "application"
end
