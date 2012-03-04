class Contact < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true
  belongs_to :region
  accepts_nested_attributes_for :region, :allow_destroy => true
  attr_accessible :address1, :address2, :city, :zip, :url, :phone, :region_attributes, :about
  def region_attributes=(attrs)
    region = Region.where(attrs).first
    self.region = region
  end

  def country
    region && region.country
  end

  def state
    region && region.state
  end
end
