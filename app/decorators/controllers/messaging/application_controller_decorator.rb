Messaging::ApplicationController.class_eval do
  include AuthenticatedSystem
  skip_filter :authenticate_messaging_user!
  before_filter :login_required
  helper_method :current_messaging_user
  
end
