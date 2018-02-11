class Ingredient < ApplicationRecord
  has_many :ingredientLists
  has_many :recipes, through: :ingredientLists
  belongs_to :product

  validates_presence_of :name
end
