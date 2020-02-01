class Meal < ApplicationRecord
  validates_presence_of :name, :portions, :price_per_portion_pence
  attribute :ingredients_cost, :integer

  has_many :recipe_lists, inverse_of: :meal, dependent: :destroy
  has_many :recipes, through: :recipe_lists

  has_many :meal_lists
  has_many :shopping_lists, through: :meal_lists

  belongs_to :user, optional: true

  accepts_nested_attributes_for :recipe_lists

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

  def use_by_days
    shortest_ubd_ingredient = ingredients.reduce { 
      |i1, i2| i1.product.use_by_days <= i2.product.use_by_days ? i1 : i2
    }

    shortest_ubd_ingredient.product.use_by_days
  end
end
