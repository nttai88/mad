class CreateCategoryRegionSelection < ActiveRecord::Migration
  def up
    remove_column :categories, :categorizable_id
    remove_column :categories, :categorizable_type
    remove_column :regions, :regionable_id
    remove_column :regions, :regionable_type
    create_table :category_selections do |t|
      t.integer :parent_id
      t.string :parent_type
      t.integer :category_id
      t.timestamps
    end
    create_table :region_selections do |t|
      t.integer :parent_id
      t.string :parent_type
      t.integer :region_id
      t.timestamps
    end
  end

  def down
    add_column :categories, :categorizable_id, :integer
    add_column :categories, :categorizable_type, :string
    add_column :regions, :regionable_id, :integer
    add_column :regions, :regionable_type, :string
    drop_table :category_selections
    drop_table :region_selections
  end
end
