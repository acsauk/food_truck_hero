class CreateProductsAndProductLists < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :brand, null: false
      t.string :unit, null: false
      t.float :amount, null: false
      t.float :price, null: false

      t.timestamps
    end

    create_table :product_lists do |t|
      t.integer :product_id, null: false, index: true
      t.integer :meal_id,    null: false, index: true

      t.timestamps
    end
  end
end
