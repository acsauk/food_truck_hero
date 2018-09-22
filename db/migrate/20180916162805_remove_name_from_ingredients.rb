class RemoveNameFromIngredients < ActiveRecord::Migration[5.1]
  def change
    remove_column :ingredients, :name, :string
  end
end
