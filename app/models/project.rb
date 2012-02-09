class Project < ActiveRecord::Base
  has_one :contact, :as => :contactable
  belongs_to :category
  has_many :region_selections, :as => :parent
  has_many :regions, :through => :region_selections, :dependent => :delete_all
  has_and_belongs_to_many :partners, :class_name => "Refinery::User", :conditions => {"projects_users.user_type" => ProjectsUser::PARTNER}
  has_and_belongs_to_many :advisors, :class_name => "Refinery::User", :conditions => {"projects_users.user_type" => ProjectsUser::ADVISOR}

  belongs_to :user, :class_name => "Refinery::User"
  
  has_many        :comments,      :as => :commentable
  
  validates :name, :presence => true
  validates :title, :presence => true
  
  has_one :document,  :dependent => :destroy
  
  ajaxful_rateable :stars => 10, :dimensions => [:teaser, :business, :market, :competitor, :strategy, :progression, :finance, :summary, :company, :attachment, :thoughts]
  
  accepts_nested_attributes_for :document
  accepts_nested_attributes_for :contact, :allow_destroy => true
  
  PROJECT_PARTS = ['teaser', 'business', 'market', 'competitor', 'strategy', 'progression', 'finance', 'summary', 'company', 'attachment', 'thoughts']

  #encrypt data
  attr_encrypted :business, :key => :encryption_key
  attr_encrypted :product_description, :key => :encryption_key
  attr_encrypted :market, :key => :encryption_key
  attr_encrypted :competitors, :key => :encryption_key
  attr_encrypted :strategy, :key => :encryption_key
  attr_encrypted :progression, :key => :encryption_key
  attr_encrypted :finances, :key => :encryption_key
  attr_encrypted :summary, :key => :encryption_key
  
  def encryption_key
    Mad2::Application.config.secret_token
  end
  
end
