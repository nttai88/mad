class CategorySelection < ActiveRecord::Base
  belongs_to :parent, :polymorphic => true
  belongs_to :category

  before_create :callback_before_create

  def callback_before_create
    self['expired_date'] ||= Time.now.next_month.to_date
  end

end
