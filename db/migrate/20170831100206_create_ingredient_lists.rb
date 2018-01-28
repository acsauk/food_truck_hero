class CreateIngredientLists < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredient_lists do |t|
      t.integer :recipe_id,     null: false
      t.integer :ingredient_id, null: false
      t.float   :amount,        null: false
      t.string  :unit,          null: false

      t.timestamps
    end
  end
end
