Refinery::UsersController.class_eval do
  skip_filter :redirect?
  def new
    @user = Refinery::User.new
    @user.roles = Refinery::Projects::Project.count
  end

  def create
    @user = Refinery::User.new(params[:user])
    @user.roles = [Refinery::Role.find(params[:user][:role_ids])] if params[:user][:role_ids]
    if @user.create_first
      flash[:message] = "<h2>#{t('welcome', :scope => 'refinery.users.create', :who => @user.username).gsub(/\.$/, '')}.</h2>".html_safe
      redirect_back_or_default(main_app.root_path)
    else
      render :action => 'new'
    end
  end

end
