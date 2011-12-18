class CategorySelection < ActiveRecord::Base
  belongs_to :parent, :polymorphic => true
  belongs_to :category
end
