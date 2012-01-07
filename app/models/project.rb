class Project < ActiveRecord::Base
  has_one :contact, :as => :contactable
  belongs_to :category
  has_many :region_selections, :as => :parent
  has_many :regions, :through => :region_selections, :dependent => :delete_all
  
  validates :name, :presence => true
  
  has_one :document,  :dependent => :destroy
  
  accepts_nested_attributes_for :document
  accepts_nested_attributes_for :contact, :allow_destroy => true
end
