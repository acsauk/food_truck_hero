class Ingredient < ApplicationRecord
  has_many :ingredientLists
  has_many :recipes, through: :ingredientLists

  validates_presence_of :name
end
