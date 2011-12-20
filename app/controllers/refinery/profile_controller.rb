class Refinery::ProfileController < ApplicationController
  layout "application"
  before_filter :login_required

  def index
    show
    render :action => :show
  end
  
  def show
    @new_emails = Conversation.unread(current_refinery_user).count
    @projects = 0
  end

  def edit
    user = Refinery::User.find_by_username(params[:id])
    @profile = user.profile
    @categories = @profile.categories
    @regions = @profile.regions
  end

  def update
    user = Refinery::User.find_by_username(params[:id])
    profile =user.profile
    categories = []
    params[:categories].each do |cat|
      categories << Category.find(cat["id"]) unless cat["id"].blank?
    end
    profile.categories = categories
    regions = []
    params[:regions].each do |reg|
      region = Region.find_by_country_and_state(reg["country"], (reg["state"] || ""))
      regions << region if region
    end if params[:regions]
    profile.regions = regions
    profile.save
    redirect_to main_app.edit_refinery_profile_path(current_refinery_user)
  end
  
end
