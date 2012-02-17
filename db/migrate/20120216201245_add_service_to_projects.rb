class AddServiceToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :service, :string
  end
end
