class AddContactToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :category_id, :integer
  end
end
