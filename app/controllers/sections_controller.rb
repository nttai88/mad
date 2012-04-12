class SectionsController < ApplicationController

  before_filter :authenticate_refinery_user!
  
  def rate
    @section = Section.find(params[:id])
    @section.rate(params[:stars], current_user, params[:dimension])
  end
end
