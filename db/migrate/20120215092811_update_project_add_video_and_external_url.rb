class UpdateProjectAddVideoAndExternalUrl < ActiveRecord::Migration
  def up
    add_column :projects, :embedded_video, :text
    add_column :projects, :external_url, :string
  end

  def down
    remove_column :projects, :embedded_video
    remove_column :projects, :external_url
  end
end
