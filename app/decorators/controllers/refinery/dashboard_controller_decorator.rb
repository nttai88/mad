Refinery::Admin::DashboardController.class_eval do
  before_filter :admin_permission?

  protected
  def admin_permission?
    if !current_refinery_user || (current_refinery_user && !current_refinery_user.has_role?(:refinery))
      redirect_to refinery.url_for(Refinery::Page.my_page_url)
    end
  end
end
