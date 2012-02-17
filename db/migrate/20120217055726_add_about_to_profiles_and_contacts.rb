class AddAboutToProfilesAndContacts < ActiveRecord::Migration
  def change
    add_column :profiles, :about, :text
    add_column :contacts, :about, :text
  end
end
