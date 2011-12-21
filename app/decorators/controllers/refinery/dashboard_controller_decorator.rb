Refinery::Admin::DashboardController.class_eval do
  before_filter :admin_permission?

  protected
  def admin_permission?
    if !current_refinery_user || (current_refinery_user && !current_refinery_user.has_role?(:refinery))
      redirect_to main_app.url_for("/my-page")
    end
  end
end
