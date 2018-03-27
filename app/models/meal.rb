class Meal < ApplicationRecord
  attribute :ingredients_cost, :integer

  has_many :recipeLists
  has_many :recipes, through: :recipeLists

  belongs_to :user

  accepts_nested_attributes_for :recipeLists

  validates_presence_of :name
  validates_presence_of :portions
  validates_presence_of :price_per_portion

  def ingredients_cost
    total_cost = 0
    recipes.each do |recipe|
      recipe.ingredients.each do |ingredient|
        total_cost += ingredient.product.smu_price * ingredient.amount
      end
    end
    total_cost
  end
end