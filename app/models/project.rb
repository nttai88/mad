class Project < ActiveRecord::Base
  has_one :contact, :as => :contactable
  belongs_to :category
  has_many :region_selections, :as => :parent
  has_many :regions, :through => :region_selections, :dependent => :delete_all
  accepts_nested_attributes_for :contact, :allow_destroy => true
  validates :name, :presence => true
end
