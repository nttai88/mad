class AddContactRegionCategory < ActiveRecord::Migration
  def up
    rename_column :profiles, :name, :first_name
    add_column :profiles, :last_name, :string
    remove_column :profiles, :address1
    remove_column :profiles, :address2
    remove_column :profiles, :country
    remove_column :profiles, :city
    remove_column :profiles, :zip
    remove_column :profiles, :phone
    remove_column :profiles, :url
    create_table :contacts, :force => true do |t|
      t.integer  :contactable_id
      t.string :contactable_type
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :zip
      t.timestamps
    end

    create_table :regions, :force => true do |t|
      t.integer :regionable_id
      t.string :regionable_type
      t.string :country
      t.string :state
      t.timestamps
    end

    create_table :categories, :force => true do |t|
      t.string :title
      t.integer :parent_id
      t.integer :categorizable_id
      t.string :categorizable_type
      t.timestamps
    end
    
  end

  def down
    rename_column :profiles, :first_name, :name
    remove_column :profiles, :last_name
    add_column :profiles, :address1, :string
    add_column :profiles, :address2, :string
    add_column :profiles, :country, :string
    add_column :profiles, :city, :string
    add_column :profiles, :zip, :string
    add_column :profiles, :phone, :string
    add_column :profiles, :url, :string
    drop_table :contacts
    drop_table :regions
    drop_table :categories
  end
end
