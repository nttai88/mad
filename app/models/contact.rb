class Contact < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true
  belongs_to :region
  accepts_nested_attributes_for :region, :allow_destroy => true
  attr_accessible :address1, :address2, :city, :zip, :url, :region_attributes
  def region_attributes=(attrs)
    region = Region.where(attrs).first
    self.region = region
  end
end
