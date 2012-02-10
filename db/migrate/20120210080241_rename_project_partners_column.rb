class RenameProjectPartnersColumn < ActiveRecord::Migration
  def up
    rename_column :projects, :partners, :industrial_partners
  end

  def down
    rename_column :projects, :industrial_partners, :partners
  end
end
