class Refinery::MypageController < ApplicationController
  layout "application"
  def index
    @new_emails = 0
    @projects = Conversation.unread(current_refinery_user).count
  end
end
