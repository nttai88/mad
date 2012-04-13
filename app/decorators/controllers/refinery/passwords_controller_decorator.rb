Refinery::PasswordsController.class_eval do
  layout 'application'


  # GET /registrations/password/edit?reset_password_token=abcdef
  def edit
    if params[:reset_password_token] and (@refinery_user = Refinery::User.where(:reset_password_token => params[:reset_password_token]).first).present?
      respond_with(@refinery_user)
    else
      redirect_to main_app.new_refinery_user_password_path,
                  :flash => ({ :error => t('code_invalid', :scope => 'refinery.users.reset') })
    end
  end

  # POST /registrations/password
  def create
    if params[:refinery_user].present? and (email = params[:refinery_user][:email]).present? and
       (user = Refinery::User.where(:email => email).first).present?

      # Call devise reset function.
      user.send(:generate_reset_password_token!)
      Refinery::UserMailer.reset_notification(user, request).deliver
      redirect_to main_app.new_refinery_user_session_path,
                  :notice => t('email_reset_sent', :scope => 'refinery.users.forgot')
    else
      flash.now[:error] = if (email = params[:refinery_user][:email]).blank?
        t('blank_email', :scope => 'refinery.users.forgot')
      else
        t('email_not_associated_with_account_html', :email => ERB::Util.html_escape(email), :scope => 'refinery.users.forgot').html_safe
      end
      render :new
    end
  end
end
