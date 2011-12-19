class CreateProfile < ActiveRecord::Migration
  def up
    create_table :profiles, :force => true do |t|
      t.integer :user_id
      t.string :name
      t.string :address1
      t.string :address2
      t.string :country
      t.string :city
      t.string :zip
      t.string :phone
      t.string :url
      t.boolean :receive_newsleter
      t.timestamps
    end
  end

  def down
  end
end
