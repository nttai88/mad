class CreateCategoriesProjects < ActiveRecord::Migration
  def change
    create_table :categories_projects, :id => false do |t|
      t.references :category
      t.references :project
    end
  end
end
