class AddCategoryToNewsItem < ActiveRecord::Migration
  def change
    add_column Refinery::News::Item.table_name, :category, :string
    add_index Refinery::News::Item.table_name, :category
  end
end
