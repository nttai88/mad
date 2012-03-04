class Category < ActiveRecord::Base
  acts_as_tree :order => "title"
  has_many :profile, :through => :category_selection
  has_and_belongs_to_many :projects
end
