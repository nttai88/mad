Refinery::UsersController.class_eval do
  skip_filter :redirect?
  before_filter :find_pages_for_menu
  layout "application"
  def new
    @user = Refinery::User.new
    @user.roles = [Refinery::Role.find_by_title("Entrepreneur")]
  end

  def create
    @user = Refinery::User.new(params[:user])
    @user.roles = [Refinery::Role.find(params[:user][:role_ids])] if params[:user][:role_ids]
    if @user.create_first
      create_internal_message
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
  end

  def update
    @user = current_refinery_user
    if params[:refinery_user][:password].blank? and params[:refinery_user][:password_confirmation].blank?
      params[:refinery_user].except!(:password, :password_confirmation)
    end
    @user.update_attributes(params[:refinery_user])
    update_profile
    if @user.save
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
      response[:message] = "Username is available!"
    else
      response[:message] = "Username #{user.errors[:username].first}"
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

  def create_internal_message
    admin = Refinery::User.joins(:roles).where("refinery_roles.title" => "Superuser").first
    if admin
      conversation = Conversation.create(:subject => "Confirmation")
      message = Message.create(:subject => "Welcome", :body => "Thank you for registering. A verification email is sent to your email account.", :sender => admin, :conversation => conversation)
      Receipt.create(:receiver => @user, :notification_id => message.id, :mailbox_type => "inbox")
    end
  end
end
