class RemoveCategoryProject < ActiveRecord::Migration
  def self.up
    drop_table :categories_projects
  end

  def self.down
    create_table :categories_projects, :id => false do |t|
      t.references :category
      t.references :project
    end
  end
end
