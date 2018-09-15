class ShoppingList < ApplicationRecord
  has_many :meal_lists, dependent: :destroy
  has_many :meals, through: :meal_lists
  has_many :shopping_list_items, dependent: :destroy
  belongs_to :user, optional: true

  # REMOVE ASSOCIATION BETWEEN ITEM AND INGREDIENT

  def add_meal(meal)
    meals << meal
    create_items_from_meal_ingredients meal
  end

  def create_items_from_meal_ingredients(meal)
    ingredients.each do |i|
      sli = ShoppingListItem.new(ingredient: i)
      shopping_list_items << sli
      sli.save!
      i.shopping_list_item = sli
      i.save!
    end
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
