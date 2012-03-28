class RemoveCategoryIdFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :category_id
  end

  def down
    add_column :projects, :category_id, :integer
  end
end
