Refinery::PagesController.class_eval do
  before_filter :login_required_for_my_page
  
  protected
  def login_required_for_my_page
    if ["my-page", "min-side"].index(params[:path])
      unless current_user
        login_required
      else
        @new_emails = Conversation.unread(current_user).count
        @projects = (current_user.admin? ? Project.count : current_user.projects.count)
      end
    end
  end

end
