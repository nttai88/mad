class Profile < ActiveRecord::Base
  belongs_to :user, :class_name => "Refinery::User"
  has_one :contact, :as => :contactable

  has_many :category_selections, :as => :parent
  has_many :region_selections, :as => :parent

  has_many :categories, :through => :category_selections, :dependent => :delete_all
  has_many :regions, :through => :region_selections, :dependent => :delete_all

  accepts_nested_attributes_for :user, :allow_destroy => true
  accepts_nested_attributes_for :contact, :allow_destroy => true
  accepts_nested_attributes_for :categories, :allow_destroy => true

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  attr_accessible :categories_attributes, :contact_attributes, :user_attributes, :first_name, :last_name,
                  :receive_newsleter, :about

  def contact_attributes=(attrs)
    unless self.contact
      self.contact = Contact.new(attrs)
    else
      self.contact.update_attributes(attrs)
    end
  end

  def selection_expiration_date
    selection = random_selection
    selection.nil? ? nil: selection.expired_date
  end

  def random_selection
    selection = self.category_selections.first
    selection = self.region_selections.first unless selection
    return selection
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
