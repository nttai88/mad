class CreateSection < ActiveRecord::Migration
  def self.up
    remove_column :projects, :encrypted_business
    remove_column :projects, :encrypted_product_description
    remove_column :projects, :encrypted_market
    remove_column :projects, :encrypted_competitors
    remove_column :projects, :encrypted_strategy
    remove_column :projects, :encrypted_progression
    remove_column :projects, :encrypted_finances
    remove_column :projects, :encrypted_summary
    create_table :section_types do |t|
      t.string :type # it should be "HtmlSectionType" or "ComplexSectionType"
      t.integer :position, :default => 0
      t.integer :parent_id, :default => 0
      t.timestamps
    end

      SectionType.create_translation_table!({
        :title => :string
      }, {:migrate_data => true})

    create_table :sections do |t|
      t.integer :project_id
      t.integer :section_type_id
      t.text :data
      t.timestamps
    end
  end

  def self.down
    add_column :projects, :encrypted_business, :string
    add_column :projects, :encrypted_product_description, :string
    add_column :projects, :encrypted_market, :string
    add_column :projects, :encrypted_competitors, :string
    add_column :projects, :encrypted_strategy, :string
    add_column :projects, :encrypted_progression, :string
    add_column :projects, :encrypted_finances, :string
    add_column :projects, :encrypted_summary, :string
    SectionType.drop_translation_table!
    drop_table :section_types
    drop_table :sections

  end
end
