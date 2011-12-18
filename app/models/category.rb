class Category < ActiveRecord::Base
  acts_as_tree :order => "title"
  has_many :profile, :through => :category_selection
end
