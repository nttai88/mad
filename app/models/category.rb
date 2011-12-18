class Category < ActiveRecord::Base
  acts_as_tree :order => "title"
  has_many :profile, :through => :category_selection

  def expired_date=(ex_date)
    @expired_date = ex_date.to_date unless ex_date.blank? rescue nil
  end

  def expired_date
    @expired_date
  end
  
end
