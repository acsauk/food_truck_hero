class Meal < ApplicationRecord
  attribute :ingredients_cost, :integer

  has_many :recipeLists
  has_many :recipes, through: :recipeLists
  has_many :mealLists
  has_many :shoppingLists, through: :mealLists

  belongs_to :user, optional: true

  accepts_nested_attributes_for :recipeLists

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

  def margin
    cost_per_portion / price_per_portion * 100
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
