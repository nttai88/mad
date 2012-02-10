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


  def advisor_candidates
    advisor_candidates = User.includes(:roles, :profile).where("refinery_roles.title" => Refinery::Role::ADVISOR)
    if advisors.size > 0
      ids = advisors.map{|x| x.id}
      advisor_candidates.delete_if{|x| ids.include?(x.id)}
    end
    return advisor_candidates
  end

  def partner_candidates
    category_selections = CategorySelection.where(:parent_type => "Profile", :category_id => self.category_id).where("expired_date is null or expired_date > '#{Time.now.to_s(:db)}'")
    profile_ids = category_selections.map{|x| x.parent_id}
    region_id = self.contact.region_id
    if region_id
      region_selections = RegionSelection.where(:parent_type => "Profile").where("expired_date is null or expired_date > '#{Time.now.to_s(:db)}'")
      profile_ids = profile_ids.concat(region_selections.map{|x| x.parent_id})
    end
    partner_candidates = User.includes(:roles, :profile).where("refinery_roles.title" => Refinery::Role.partner_roles, "profiles.id" => profile_ids.uniq!)
    if partners.size > 0
      ids = partners.map{|x| x.id}
      partner_candidates.delete_if{|x| ids.include?(x.id)}
    end
    return partner_candidates
  end

end
