class RemoveTextToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :text, :string
  end
end
