Messaging::ApplicationController.class_eval do
  include Refinery::AuthenticatedSystem
  include Refinery::ApplicationController
  include Refinery::Pages::InstanceMethods
  include CommonHelpers
  skip_filter :authenticate_messaging_user!
  before_filter :authenticate_refinery_user!
  helper_method :current_messaging_user,
                :available_locals, :current_url_with_locale

  def current_messaging_user
    current_refinery_user
  end
  
end
