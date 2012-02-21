class DocumentChangeProjectIdToDocumentable < ActiveRecord::Migration
  def up
#    rename_column :documents, :project_id, :documentable_id
#    add_column :documents, :documentable_type, :string
#    Document.update_all("documentable_type = 'Project'")
    add_column :projects, :use_user_avatar, :boolean
  end

  def down
    rename_column :documents, :project_id, :documentable_id
    remove_column :documents, :documentable_type
    remove_column :projects, :use_user_avatar, :boolean
  end
end
