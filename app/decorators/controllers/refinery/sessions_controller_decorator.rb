Refinery::SessionsController.class_eval do
  layout 'application'

  skip_before_filter :force_ssl, :only => :destroy
end
