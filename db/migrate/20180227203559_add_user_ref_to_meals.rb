class AddUserRefToMeals < ActiveRecord::Migration[5.1]
  def change
    add_reference :meals, :user, index: true, foreign_key: true
  end
end
