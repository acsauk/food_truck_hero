class AddShoppingListRefToShoppingListItems < ActiveRecord::Migration[5.1]
  def change
    change_table :shopping_list_items do |t|
      t.belongs_to :shopping_list, index: true, foreign_key: true
    end
  end
end
