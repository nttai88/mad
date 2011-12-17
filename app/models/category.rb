class Category < ActiveRecord::Base
  acts_as_tree :order => "title"
  belongs_to :categorizable, :polymorphic => true
end
