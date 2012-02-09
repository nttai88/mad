class CreateProjectUser < ActiveRecord::Migration
  def up
    create_table :projects_users do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :user_type
      t.timestamps
    end
  end

  def down
    drop_table :project_users
  end
end
