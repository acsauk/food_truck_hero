class AddNameToShoppingList < ActiveRecord::Migration[5.1]
  def change
    add_column :shopping_lists, :name, :string, null: true
  end
end
