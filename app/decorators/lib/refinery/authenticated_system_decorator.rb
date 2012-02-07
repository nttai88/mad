Refinery::AuthenticatedSystem.module_eval do
  def after_sign_in_path_for(resource_or_scope)
    main_app.root_path
  end
end
