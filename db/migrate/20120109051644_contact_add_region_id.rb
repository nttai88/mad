class ContactAddRegionId < ActiveRecord::Migration
  def up
    add_column :contacts, :region_id, :integer
  end

  def down
    remove_column :contacts, :region_id
  end
end
