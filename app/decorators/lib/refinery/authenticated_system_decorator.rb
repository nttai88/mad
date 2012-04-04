Refinery::AuthenticatedSystem.module_eval do
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || refinery.url_for("/my-page")
  end
end
