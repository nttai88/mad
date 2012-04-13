Refinery::UsersController.class_eval do
  skip_filter :redirect?
  layout 'application'
  def new
    @user = Refinery::User.new
    @user.roles = [Refinery::Role.find_by_title("Entrepreneur")]
  end

  def create
    @user = Refinery::User.new(params[:user])
    @user.roles = [Refinery::Role.find(params[:user][:role_ids])] if params[:user][:role_ids]
    if @user.create_user
      set_flash_message(:notice, :confirmed)
      redirect_back_or_default(refinery.root_path)
    else
      render :action => 'new'
    end
  end

  def show
    render :text => "The feature is under construction."
  end

  def edit
    @user =  current_refinery_user
  end

  def update
    @user = current_refinery_user
    if params[:refinery_user][:password].blank? and params[:refinery_user][:password_confirmation].blank?
      params[:refinery_user].except!(:password, :password_confirmation)
    end
    @user.update_attributes(params[:refinery_user])
    update_profile
    if @user.save
      set_flash_message :notice, :updated
      redirect_to main_app.edit_refinery_user_path(@user)
    else
      render :action => :edit
    end
    
  end

  def check_username_availability
    user = Refinery::User.new(:username => params[:username])
    user.valid?
    status = user.errors[:username].blank?
    response = {:status => status}
    if status
      response[:message] =  t('message.available',:what=>user.class.human_attribute_name(:username))
    else
      response[:message] = "#{user.class.human_attribute_name(:username)} #{user.errors[:username].first}"
    end
    render :json => response
  end
  
  protected
  def update_profile
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
  end

end
