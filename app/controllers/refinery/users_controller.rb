module Refinery
  class UsersController < ::Devise::RegistrationsController

    layout 'login'

    def new
      @user = User.new
    end

    # This method should only be used to create the first Refinery user.
    def create
      @user = User.new(params[:user])

      if @user.create_first
        flash[:message] = "<h2>#{t('welcome', :scope => 'refinery.users.create', :who => @user.username).gsub(/\.$/, '')}.</h2>".html_safe

        sign_in(@user)
        redirect_back_or_default(main_app.refinery_admin_root_path)
      else
        render :action => 'new'
      end
    end

  end
end
