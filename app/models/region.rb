class Region < ActiveRecord::Base
  has_many :profile, :through => :region_selection

  def expired_date=(ex_date)
    @expired_date = ex_date.to_date unless ex_date.blank? rescue nil
  end

  def expired_date
    @expired_date
  end
  
end
