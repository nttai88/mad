class SectionType < ActiveRecord::Base
  validates :title, :presence => true

  has_many :sections
  acts_as_tree :order => "position"
  translates :title
  default_scope :order => "position"

end
