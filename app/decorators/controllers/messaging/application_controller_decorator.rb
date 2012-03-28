Messaging::ApplicationController.class_eval do
  include AuthenticatedSystem
  include Refinery::AuthenticatedSystem
  include Refinery::ApplicationController::InstanceMethods
  include Refinery::Pages::InstanceMethods
  skip_filter :authenticate_messaging_user!
  before_filter :login_required
  helper_method :current_messaging_user, 
                :home_page?,
                :local_request?,
                :just_installed?,
                :from_dialog?,
                :admin?,
                :login?,
                :available_locals, :current_url_with_locale
  before_filter  :find_pages_for_menu, :refinery_user_required?
  
end
