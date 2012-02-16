class AddAvatarToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :avatar, :string
  end
end
