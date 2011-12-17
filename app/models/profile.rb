class Profile < ActiveRecord::Base
  belongs_to :user, :class_name => "Refinery::User"
  has_one :contact, :as => :contactable
  has_many :categories, :as => :categorizable
  has_many :regions, :as => :regionable
  accepts_nested_attributes_for :contact, :allow_destroy => true

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  attr_accessible :contact_attributes, :first_name, :last_name, :receive_newsleter
  def contact_attributes=(attrs)
    self.contact = Contact.new(attrs)
  end
end
