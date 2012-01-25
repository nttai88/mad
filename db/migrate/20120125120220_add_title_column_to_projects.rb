class AddTitleColumnToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :title, :string
    add_column :projects, :network_only, :boolean
    add_column :projects, :need_investor, :boolean
    add_column :projects, :need_producer, :boolean
    add_column :projects, :need_retail, :boolean
    rename_column :projects, :owner_name, :project_name
    rename_column :projects, :description, :business
  end
end