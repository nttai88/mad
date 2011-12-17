Refinery::Admin::DashboardController.class_eval do
  before_filter :admin_permission?

  protected
  def admin_permission?
    if !current_refinery_user || (current_refinery_user && !current_refinery_user.has_role?(:refinery))
      redirect_to main_app.refinery_mypage_index_path
    end
  end
end
