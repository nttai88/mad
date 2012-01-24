class AddCategoryToNewsItem < ActiveRecord::Migration
  def change
    add_column Refinery::NewsItem.table_name, :category, :string
    add_index Refinery::NewsItem.table_name, :category
  end
end
