class ProjectChangeEncryptedColumns < ActiveRecord::Migration
  def up
    rename_column :projects, :business, :encrypted_business
    rename_column :projects, :product_description, :encrypted_product_description
    rename_column :projects, :market, :encrypted_market
    rename_column :projects, :competitors, :encrypted_competitors
    rename_column :projects, :strategy, :encrypted_strategy
    rename_column :projects, :progression, :encrypted_progression
    rename_column :projects, :finances, :encrypted_finances
    rename_column :projects, :summary, :encrypted_summary
  end

  def down
    rename_column :projects, :encrypted_business, :business
    rename_column :projects, :encrypted_product_description, :product_description
    rename_column :projects, :encrypted_market, :market
    rename_column :projects, :encrypted_competitors, :competitors
    rename_column :projects, :encrypted_strategy, :strategy
    rename_column :projects, :encrypted_progression, :progression
    rename_column :projects, :encrypted_finances, :finances
    rename_column :projects, :encrypted_summary, :summary
  end
end
