class AddExpiredDateColumn < ActiveRecord::Migration
  def up
    add_column :region_selections, :expired_date, :date
    add_column :category_selections, :expired_date, :date
  end

  def down
    remove_column :region_selections, :expired_date
    remove_column :category_selections, :expired_date
  end
end
