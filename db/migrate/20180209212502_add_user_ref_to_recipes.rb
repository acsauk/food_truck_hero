class AddUserRefToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_reference :recipes, :user, index: true, foreign_key: true
  end
end
