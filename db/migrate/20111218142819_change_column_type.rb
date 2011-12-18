class ChangeColumnType < ActiveRecord::Migration
  def up
    change_table :profiles do |t|
      t.change :user_id, :integer
    end
  end

  def down
    change_table :profiles do |t|
      t.change :user_id, :string
    end
  end
end
