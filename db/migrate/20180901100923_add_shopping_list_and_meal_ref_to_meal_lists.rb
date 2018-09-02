class AddShoppingListAndMealRefToMealLists < ActiveRecord::Migration[5.1]
  def change
    create_table :meal_lists do |t|
      t.belongs_to :meal, index: true, foreign_key: true
      t.belongs_to :shopping_list, index: true, foreign_key: true
    end
  end
end
