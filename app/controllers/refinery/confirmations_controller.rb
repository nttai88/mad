class Refinery::ConfirmationsController < Devise::ConfirmationsController
  layout 'application'
  before_filter :find_pages_for_menu
end

