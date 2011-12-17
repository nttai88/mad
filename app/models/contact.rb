class Contact < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true
  has_one :region, :as => :regionable
  accepts_nested_attributes_for :region, :allow_destroy => true
  attr_accessible :address1, :address2, :city, :zip, :url, :region_attributes
  def region_attributes=(attrs)
    self.region = Region.new(attrs)
  end
end
