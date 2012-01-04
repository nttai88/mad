class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :owner_name
      t.string :name
      t.text :usage
      t.text :solves
      t.text :idea
      t.text :description
      t.text :market
      t.text :competitors
      t.text :strategy
      t.text :progression
      t.text :finances
      t.text :summary
      t.text :marked_geographic
      t.text :marked_size
      t.string :developed
      t.boolean :need_company
      t.boolean :founder
      t.boolean :develop_in_own_company
      t.text :partners
      t.text :suppliers
      t.text :distributers
      t.text :patenting
      t.text :competitors2
      t.text :origin

      t.timestamps
    end
  end
end
