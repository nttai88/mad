module Messaging
  module ApplicationHelper
    include Refinery::SiteBarHelper
    include Refinery::MenuHelper
    include Refinery::MetaHelper
    include CommonHelpers

    def receivers(m)
      result = m.last_message.recipients.map{|x| x.to_s}.uniq
      result.delete_if{|x| x == current_messaging_user.to_s} if result.size > 1
      result.join(", ")
    end
  end
end
