Refinery::UsersController.class_eval do
  skip_filter :redirect?
  before_filter :login_required, :find_pages_for_menu, :only => [:edit, :update]
  
  def new
    @user = Refinery::User.new
    @user.roles = [Refinery::Role.find_by_title("Entrepreneur")]
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

  def show
    render :text => "The feature is under construction."
  end

  def edit
    @user =  current_refinery_user
    profile = @user.profile
    @categories = profile.categories
    @regions = profile.regions
    render :layout => "application"
  end

  def update
    @user = current_refinery_user
    if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      params[:user].except!(:password, :password_confirmation)
    end
    @user.update_attributes(params[:user])
    profile = @user.profile
    if params[:categories]
      categories = []
      params[:categories].each do |cat|
        categories << Category.find(cat["id"]) unless cat["id"].blank?
      end
      profile.categories = categories
    end
    if params[:regions]
      regions = []
      params[:regions].each do |reg|
        region = Region.find_by_country_and_state(reg["country"], (reg["state"] || ""))
        regions << region if region
      end if params[:regions]
      profile.regions = regions
    end
    if @user.save
      redirect_to main_app.edit_refinery_user_path(@user)
    else
      render :action => :edit, :layout => "application"
    end
    
  end
  
end
