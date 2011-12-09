class User < Refinery::User
  set_table_name "refinery_users"
  has_one :profile
  accepts_nested_attributes_for :profile, :allow_destroy => true
  accepts_nested_attributes_for :roles, :allow_destroy => true

  def profile=(p)
    p.user = self
  end
end
