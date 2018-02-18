class CreateRecipeLists < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_lists do |t|
      t.integer :recipe_id, null: false, index: true
      t.integer :meal_id,   null: false, index: true
    end
  end
end
