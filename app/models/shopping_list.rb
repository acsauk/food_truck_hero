class ShoppingList < ApplicationRecord
  has_many :meal_lists, dependent: :destroy
  has_many :meals, through: :meal_lists
  belongs_to :user, optional: true

  # REMOVE ASSOCIATION BETWEEN ITEM AND INGREDIENT

  def add_meal(meal)
    meals << meal
  end

  def ingredients
    ingredients_array = []
    meals.each do |meal|
      meal.ingredients.each do |ingredient|
        ingredients_array << ingredient
      end
    end
    ingredients_array
  end
end
