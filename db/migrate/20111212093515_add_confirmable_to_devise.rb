class AddConfirmableToDevise < ActiveRecord::Migration
  def self.up
    add_column :refinery_users, :confirmation_token, :string
    add_column :refinery_users, :confirmed_at,       :datetime
    add_column :refinery_users, :confirmation_sent_at , :datetime

    add_index  :refinery_users, :confirmation_token, :unique => true
  end
  def self.down
    remove_index  :refinery_users, :confirmation_token

    remove_column :refinery_users, :confirmation_sent_at
    remove_column :refinery_users, :confirmed_at
    remove_column :refinery_users, :confirmation_token
  end

end
