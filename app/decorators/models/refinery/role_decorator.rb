Refinery::Role.class_eval do
  
  def self.admin_roles
    ["Refinery", "Superuser"]
  end

  def self.partner_roles
    ["Distributor", "Contractor", "Producer", "Investor"]
  end

  def self.user_roles
    ["Entrepreneur", "AdvisorRequest"] + partner_roles
  end

  def self.all_roles
    admin_roles + user_roles + ["Advisor"]
  end
end
