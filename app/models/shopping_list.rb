class ShoppingList < ApplicationRecord
  has_many :meal_lists
  has_many :meals, through: :meal_lists
  has_many :shopping_list_items
  belongs_to :user, optional: true

  def add_meal(meal)
    meals << meal
  end

  def create_items_from_ingredients(meal)
    meal.ingredients.each do |i|
      shopping_list_item.ingredient = i
    end
  end
end
