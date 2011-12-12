Refinery::UsersController.class_eval do
  skip_filter :redirect?
  def new
    @user = Refinery::User.new
    @user.roles = [Refinery::Role.find_by_title("Entrepreneur")]
  end

  def create
    @user = Refinery::User.new(params[:user])
    @user.profile = Profile.new(params[:user][:profile]) if params[:user][:profile]
    @user.roles = [Refinery::Role.find(params[:user][:role_ids])] if params[:user][:role_ids]
    if @user.create_first
      flash[:message] = "<h2>#{t('welcome', :scope => 'refinery.users.create', :who => @user.username).gsub(/\.$/, '')}.</h2>".html_safe
      if(@user.has_role?(:refinery))
        sign_in(@user)
        redirect_back_or_default(main_app.refinery_admin_root_path)
      else
        redirect_back_or_default(main_app.root_path)
      end
    else
      render :action => 'new'
    end
  end
end
