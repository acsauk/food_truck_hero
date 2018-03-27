class ChangePricePerPortionAndPriceColumnsToIntegers < ActiveRecord::Migration[5.1]
  def up
    remove_column :meals, :price_per_portion
    add_column :meals, :price_per_portion_pence, :integer

    remove_column :products, :price
    add_column :products, :price_pence, :integer
  end

  def down
    remove_column :meals, :price_per_portion
    add_column :meals, :price_per_portion_pence, :float

    remove_column :products, :price_pence
    add_column :products, :price, :float
  end
end
