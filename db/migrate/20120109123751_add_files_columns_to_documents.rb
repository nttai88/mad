class AddFilesColumnsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :file1, :string
    add_column :documents, :file2, :string
    add_column :documents, :file3, :string
    add_column :documents, :file4, :string
    add_column :documents, :file5, :string
    add_column :documents, :file6, :string
    add_column :documents, :file7, :string
    add_column :documents, :file8, :string
    add_column :documents, :file9, :string
  end
end
