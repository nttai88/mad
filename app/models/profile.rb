class Profile < ActiveRecord::Base
  belongs_to :user, :class_name => "Refinery::User"
end
