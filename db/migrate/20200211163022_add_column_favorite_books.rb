class AddColumnFavoriteBooks < ActiveRecord::Migration[6.0]
  def change
      add_column :books, :favorite_books, :boolean
  end
end
