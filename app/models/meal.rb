class Meal < ApplicationRecord
  attribute :ingredients_cost, :integer

  has_many :recipe_lists, inverse_of: :meal, dependent: :destroy
  has_many :recipes, through: :recipe_lists

  has_many :meal_lists
  has_many :shopping_lists, through: :meal_lists

  belongs_to :user, optional: true

  accepts_nested_attributes_for :recipe_lists

  validates_presence_of :name
  validates_presence_of :portions
  validates_presence_of :price_per_portion_pence

  monetize :price_per_portion_pence

  def ingredients_cost
    total_cost = 0
    ingredients.each do |ingredient|
      total_cost += ingredient.product.smu_price * ingredient.amount
    end
    Money.new(total_cost)
  end

  def cost_per_portion
    Money.new(ingredients_cost / portions)
  end

  def profit_per_portion
    Money.new(price_per_portion_pence) - cost_per_portion
  end

  def margin
    profit_per_portion / Money.new(price_per_portion_pence) * 100
  end

  def ingredients
    ingredients_array = []
    recipes.each do |recipe|
      recipe.ingredients.each do |ingredient|
        ingredients_array << ingredient
      end
    end
    ingredients_array
  end
end
