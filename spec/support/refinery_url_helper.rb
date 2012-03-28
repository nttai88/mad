module RefineryUrlHelper
  def refinery
    Refinery::Core::Engine.routes.url_helpers
  end
end
