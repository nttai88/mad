Refinery::User.class_eval do
  has_one :profile
  accepts_nested_attributes_for :profile, :allow_destroy => true

    def create_first
      if valid?
        if Refinery::Role[:refinery].users.count == 0
          # first we need to save user
          save
          # add refinery role
          add_role(:refinery)
          # add superuser role
          add_role(:superuser)
        end
      end
      # return true/false based on validations
      valid?
    end
end