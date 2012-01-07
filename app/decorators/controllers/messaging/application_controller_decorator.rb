Messaging::ApplicationController.class_eval do
  include AuthenticatedSystem
  include Refinery::AuthenticatedSystem
  include Refinery::ApplicationController::InstanceMethods
  include Refinery::Pages::InstanceMethods
#  include Refinery::ApplicationController
  skip_filter :authenticate_messaging_user!
  before_filter :login_required
  helper_method :current_messaging_user, 
                :home_page?,
                :local_request?,
                :just_installed?,
                :from_dialog?,
                :admin?,
                :login?

  protect_from_forgery # See ActionController::RequestForgeryProtection

  include Refinery::Crud # basic create, read, update and delete methods

  before_filter  :find_pages_for_menu, :show_welcome_page?

  after_filter :store_current_location!, :if => Proc.new {|c| refinery_user? }
  
end
