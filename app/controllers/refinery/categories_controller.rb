class Refinery::CategoriesController < ApplicationController
  layout "application"
  
  def edit
    user = Refinery::User.find_by_username(params[:id])
    @categories = user.profile.categories
  end

  def create
    user = Refinery::User.find_by_username(params[:id])
    profile =user.profile
    categories = []
    params[:categories].each do |cat|
      categories << Category.find(cat["id"]) unless cat["id"].blank?
    end
    profile.categories = categories
    profile.save
    redirect_to main_app.edit_refinery_category_path(current_refinery_user)
  end
end
