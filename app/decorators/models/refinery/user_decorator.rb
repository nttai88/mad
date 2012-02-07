Refinery::User.class_eval do
  ajaxful_rater
  has_one :profile
  has_many :projects
  has_many :comments
  accepts_nested_attributes_for :profile, :allow_destroy => true
  devise :confirmable
  include Mailboxer::Models::Messageable
  acts_as_messageable
  attr_accessible :profile_attributes, :role_ids
  after_save :create_profile
  validates :username, :length => { :minimum => 3}

  def profile_attributes=(attrs)
    unless self.profile
      self.profile = Profile.new(attrs)
    else
      self.profile.update_attributes(attrs)
    end
  end

  def create_first
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

  def is_partner?
    Refinery::Role.partner_roles.each do |role|
      if self.has_role?(role)
        return true
      end
    end
    return false
  end

  protected
  def create_profile
    self.profile = Profile.new(:first_name => self.username, :last_name => self.username) unless self.profile
  end
end
