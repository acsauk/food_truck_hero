class AddShoppingListItemRefToIngredient < ActiveRecord::Migration[5.1]
  def up
    add_reference :ingredients, :shopping_list_item, index: true, foreign_key: true
  end

  def down
    remove_reference :ingredients, :shopping_list_item, index: true, foreign_key: true
  end
end
