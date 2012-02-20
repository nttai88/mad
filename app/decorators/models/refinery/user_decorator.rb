Refinery::User.class_eval do
  ajaxful_rater
  has_one :profile
  has_many :projects
  has_many :comments
  has_and_belongs_to_many :partner_of_projects, :class_name => "Project", :conditions => {"projects_users.user_type" => ProjectsUser::PARTNER}
  has_and_belongs_to_many :advisor_of_projects, :class_name => "Project", :conditions => {"projects_users.user_type" => ProjectsUser::ADVISOR}
  accepts_nested_attributes_for :profile, :allow_destroy => true
  devise :confirmable
  include Mailboxer::Models::Messageable
  acts_as_messageable
  attr_accessible :profile_attributes, :role_ids
  after_save :create_profile
  validates :username, :length => { :minimum => 4}, :format => { :with =>  /^[A-Za-z\d_\.\-\_ ]+$/i}

  def profile_attributes=(attrs)
    unless self.profile
      self.profile = Profile.new(attrs)
    else
      self.profile.update_attributes(attrs)
    end
  end

  def create_user
    if valid?
      # first we need to save user
      save
      if Refinery::Role[:refinery].users.count == 0
        # add refinery role
        add_role(:refinery)
        # add superuser role
        add_role(:superuser)
      end
    end
    # return true/false based on validations
    valid?
  end

  def name
    self.to_s
  end

  def mailboxer_email(message)
    email
  end

  def to_s
    email
  end

  def admin?
    self.has_role?(Refinery::Role::REFINERY)
  end

  def is_partner?
    Refinery::Role.partner_roles.each do |role|
      if self.has_role?(role)
        return true
      end
    end
    return false
  end

  def can_create_project?
    ["Refinery", "Entrepreneur"].each do |role|
      if self.has_role?(role)
        return true
      end
    end
    return false
  end

  def can_edit_project?(project)
    return true if self.has_role?("Refinery")
    return self.has_role?("Entrepreneur") && project.user_id == self.id ? true :false
  end

  def partner_of?(project)
    project = partner_of_projects.where("projects_users.project_id" => project.id)
    return project.empty? ? false : true
  end

  def advisor_of?(project)
    project = advisor_of_projects.where("projects_users.project_id" => project.id)
    return project.empty? ? false : true
  end

  def full_name
    profile.full_name
  end

  def partnerable_projects
    categories = CategorySelection.where(:parent_type => "Profile", :parent_id => self.profile.id).where("expired_date is null or expired_date > '#{Time.now.to_s(:db)}'").map{|x| x.category_id}
    regions = RegionSelection.where(:parent_type => "Profile", :parent_id => self.profile.id).where("expired_date is null or expired_date > '#{Time.now.to_s(:db)}'").map{|x| x.region_id}
    conditions = {}
    conditions[:category_id] = categories unless categories.empty?
    conditions["contacts.region_id"] = regions unless regions.empty?
    Project.joins(:contact).where(conditions)
  end
  protected
  def create_profile
    self.profile = Profile.new(:first_name => self.username, :last_name => self.username) unless self.profile
  end
end
