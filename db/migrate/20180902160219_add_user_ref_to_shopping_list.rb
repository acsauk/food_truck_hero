class AddUserRefToShoppingList < ActiveRecord::Migration[5.1]
  def change
    add_reference :shopping_lists, :user, index: true, foreign_key: true
  end
end
