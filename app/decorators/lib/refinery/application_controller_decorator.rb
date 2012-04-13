Refinery::ApplicationController.module_eval do

  protected
  def refinery_user_required?
    if just_installed? and controller_name != 'users'
      redirect_to main_app.new_refinery_user_registration_path
    end
  end

end