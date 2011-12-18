class Refinery::MypageController < ApplicationController
  layout "application"
  def index
    @new_emails = Conversation.unread(current_refinery_user).count
    @projects = 0
  end
end
