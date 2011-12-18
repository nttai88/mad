class RegionSelection < ActiveRecord::Base
  belongs_to :parent, :polymorphic => true
  belongs_to :region
end
