Messaging::ApplicationController.class_eval do
  include AuthenticatedSystem
  include Refinery::AuthenticatedSystem
  include Refinery::ApplicationController
  include Refinery::Pages::InstanceMethods
  include CommonHelpers
  skip_filter :authenticate_messaging_user!
  before_filter :login_required
  helper_method :current_messaging_user,
                :available_locals, :current_url_with_locale
end
