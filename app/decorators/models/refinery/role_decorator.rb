Refinery::Role.class_eval do
  ADVISOR = "Advisor"
  REFINERY = "Refinery"
  SUPERUSER = "Superuser"
  DISTRIBUTOR = "Distributor"
  CONTRACTOR = "Contractor"
  PRODUCER = "Producer"
  INVESTOR = "Investor"
  ENTREPRENEUR = "Entrepreneur"
  ADVISOR_REQUEST = "AdvisorRequest"
  def self.admin_roles
    [REFINERY, SUPERUSER]
  end

  def self.partner_roles
    [DISTRIBUTOR, CONTRACTOR, PRODUCER, INVESTOR]
  end

  def self.user_roles
    [ENTREPRENEUR, ADVISOR_REQUEST] + partner_roles
  end

  def self.all_roles
    admin_roles + user_roles + [ADVISOR]
  end
end
