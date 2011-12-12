Refinery::Role.class_eval do

  def self.admin_roles
    ["Refinery", "Superuser"]
  end

  def self.user_roles
    ["Entrepreneur", "Advisor", "Distributor", "Contractor", "Producer", "Investor"]
  end
end
