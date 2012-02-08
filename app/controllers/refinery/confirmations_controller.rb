class Refinery::ConfirmationsController < Devise::ConfirmationsController
  layout 'application'
  before_filter :find_pages_for_menu

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      redirect_to main_app.root_path
    end
  end
end
