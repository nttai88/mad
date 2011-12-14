Messaging::MessagesController.class_eval do
  skip_filter :authenticate_messaging_user!
  helper_method :current_messaging_user
  
  def current_messaging_user
    current_refinery_user
  end
end
