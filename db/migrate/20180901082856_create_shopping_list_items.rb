class CreateShoppingListItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_list_items do |t|
      t.boolean :purchased

      t.timestamps
    end
  end
end
