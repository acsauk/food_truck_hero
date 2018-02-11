class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :brand, null: false
      t.string :unit, null: false
      t.float :size, null: false
      t.float :price, null: false

      t.timestamps
    end

    add_reference :ingredients, :product, index: true, foreign_key: true
  end
end
