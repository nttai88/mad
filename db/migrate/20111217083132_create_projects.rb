class CreateProjects < ActiveRecord::Migration

  def up
    create_table :refinery_projects do |t|
      t.string :owner_name
      t.string :name
      t.string :title
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
      t.boolean :license_to_company
      t.text :partners
      t.text :suppliers
      t.text :distributors
      t.text :patenting
      t.text :competitors2
      t.text :origin
      t.integer :position

      t.timestamps
    end

    Refinery::Projects::Engine.load_seed
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "projects"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/projects"})
    end

    drop_table :refinery_projects
  end

end
