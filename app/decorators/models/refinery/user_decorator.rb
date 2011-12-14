Refinery::User.class_eval do
  has_one :profile
  accepts_nested_attributes_for :profile, :allow_destroy => true

  devise :confirmable
  include Mailboxer::Models::Messageable
  acts_as_messageable
  
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
end
