class AddSourceToNewsItems < ActiveRecord::Migration

  def up
    unless Refinery::News::Item.column_names.map(&:to_sym).include?(:source)
      add_column Refinery::News::Item.table_name, :source, :string
    end
  end

  def down
    if Refinery::News::Item.column_names.map(&:to_sym).include?(:source)
      remove_column Refinery::News::Item.table_name, :source
    end
  end

end