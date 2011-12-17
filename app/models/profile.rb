class Profile < ActiveRecord::Base
  belongs_to :user, :class_name => "Refinery::User"
  has_one :contact, :as => :contactable
  has_many :categories, :as => :categorizable
  has_many :regions, :as => :regionable
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
end
