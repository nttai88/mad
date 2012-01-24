class AddFieldsToProjectAndContact < ActiveRecord::Migration
  def change
    add_column :projects, :product_description, :text
    add_column :projects, :licensing, :boolean
    add_column :contacts, :phone, :string
  end
end
