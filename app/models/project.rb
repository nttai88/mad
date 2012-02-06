class Project < ActiveRecord::Base
  ajaxful_rateable :stars => 10, :dimensions => [:teaser, :business, :market, :competitor, :strategy, :progression, :finance, :summary, :company, :attachment, :thoughts]
  has_one :contact, :as => :contactable
  belongs_to :category
  has_many :region_selections, :as => :parent
  has_many :regions, :through => :region_selections, :dependent => :delete_all
  belongs_to :user, :class_name => "Refinery::User"
  
  has_many        :comments,      :as => :commentable
  
  validates :name, :presence => true
  
  has_one :document,  :dependent => :destroy
  
  accepts_nested_attributes_for :document
  accepts_nested_attributes_for :contact, :allow_destroy => true
  
  PROJECT_PARTS = ['teaser', 'business', 'market', 'competitor', 'strategy', 'progression', 'finance', 'summary', 'company', 'attachment', 'thoughts']
end
