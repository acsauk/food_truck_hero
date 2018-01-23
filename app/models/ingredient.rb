class Ingredient < ApplicationRecord
  has_many :ingredientLists
  has_many :recipes, through: :ingredientLists
end
