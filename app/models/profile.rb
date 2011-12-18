class Profile < ActiveRecord::Base
  belongs_to :user, :class_name => "Refinery::User"
  has_one :contact, :as => :contactable

  has_many :category_selections, :as => :parent
  has_many :region_selections, :as => :parent

  has_many :categories, :through => :category_selections, :dependent => :delete_all
  has_many :regions, :through => :region_selections, :dependent => :delete_all

  accepts_nested_attributes_for :contact, :allow_destroy => true
  accepts_nested_attributes_for :categories, :allow_destroy => true

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  attr_accessible :categories_attributes, :contact_attributes, :first_name, :last_name, :receive_newsleter
  def contact_attributes=(attrs)
    self.contact = Contact.new(attrs)
  end

  def selection_of(obj)
    if obj.kind_of?(Category)
      selection = self.category_selections.where(:category_id => obj.id).first
    elsif obj.kind_of?(Region)
      selection = self.region_selections.where(:region_id => obj.id).first
    end
    selection
  end

  def expired_date_of(obj)
    selection = selection_of(obj)
    selection.nil? ? nil: selection.expired_date
  end
end
