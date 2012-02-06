class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user, :class_name => "Refinery::User"
  validates :commentable_id, :presence => true
  validates :commentable_type, :presence => true
  validates :comment, :presence => true
end
