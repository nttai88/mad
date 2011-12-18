class Refinery::RegionsController < ApplicationController
  layout "application"

  def new
    
  end

  def edit
    user = Refinery::User.find_by_username(params[:id])
    @profile = user.profile
    @regions = @profile.regions
  end

  def update

  end

end
