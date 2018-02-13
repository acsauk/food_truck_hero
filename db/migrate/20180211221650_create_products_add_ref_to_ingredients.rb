class CreateProductsAddRefToIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :brand, null: false
      t.string :unit, null: false
      t.float :amount, null: false
      t.float :price, null: false

      t.timestamps
    end

    change_table :ingredients do |t|
      t.belongs_to :product, index: { unique: true }, foreign_key: true
    end
  end
end
