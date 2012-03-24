Refinery::PagesController.class_eval do
  before_filter :login_required_for_my_page
  
  protected
  def login_required_for_my_page
    if params[:path] == "my-page"
      unless current_user
        login_required
      else
        @new_emails = Conversation.unread(current_refinery_user).count
        @projects = current_user.projects.size
      end
    end
  end

end
