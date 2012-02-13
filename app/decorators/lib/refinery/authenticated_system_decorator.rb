Refinery::AuthenticatedSystem.module_eval do
  def after_sign_in_path_for(resource_or_scope)
    main_app.url_for("/my-page")
  end
end
