class Refinery::CategoriesController < ApplicationController
  layout "application"
  def edit
    user = Refinery::User.find_by_username(params[:id])
    @profile = user.profile
    @categories = @profile.categories
  end

  def update

  end

end
