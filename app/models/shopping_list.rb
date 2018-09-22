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

  def shopping_list_items
    grouped_ingredients = split_ingredients_by_name

    shopping_list_items = []
    grouped_ingredients.values.each do |ingredients|
      shopping_list_items << convert_identical_ingredients_to_shopping_list_item(ingredients)
    end
    
    shopping_list_items
  end

  def split_ingredients_by_name
    ingredients.group_by { |ingredient| ingredient.name }
  end

  def convert_identical_ingredients_to_shopping_list_item(ingredients)
    shopping_list_item =
      ShoppingListItem.new(
        name: ingredients.first.name,
        amount: 0,
        unit: ingredients.first.unit,
        purchased: false
      )

    ingredients.each do |ingredient|
      shopping_list_item.amount += ingredient.amount
    end

    shopping_list_item
  end


end
