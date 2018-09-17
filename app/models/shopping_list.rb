class ShoppingList < ApplicationRecord
  has_many :meal_lists, dependent: :destroy
  has_many :meals, through: :meal_lists
  belongs_to :user, optional: true

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

  def combine_identical_ingredients
    # Receive an array of ingredient objects
    # split into seperate arrays based on ingredient id
    # Iterate over each array and add the amounts together
    # Reduce each array to single ingredient
    # Put the ingredients back together in an array and return
  end

  def split_ingredients_by_id
    ingredients.group_by { |ingredient| ingredient.id }
  end

  def accumulate_ingredient_amounts(ingredients)
    # Iterate over each array and add the amounts together
  end
end
