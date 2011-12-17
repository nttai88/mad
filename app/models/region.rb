class Region < ActiveRecord::Base
  belongs_to :regionable, :polymorphic => true
end
