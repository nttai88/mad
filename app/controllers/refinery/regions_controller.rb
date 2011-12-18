class Refinery::RegionsController < ApplicationController
  layout "application"

  def edit
    user = Refinery::User.find_by_username(params[:id])
    @profile = user.profile
    @regions = @profile.regions
  end

  def create
    user = Refinery::User.find_by_username(params[:id])
    @profile =user.profile
    regions = []
    params[:regions].each do |reg|
      region = Region.find_by_country_and_state(reg["country"], (reg["state"] || ""))
      regions << region if region
    end if params[:regions]
    @profile.regions = regions
    @profile.save
    redirect_to main_app.edit_refinery_region_path(current_refinery_user)
  end

end
