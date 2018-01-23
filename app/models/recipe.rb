class Recipe < ApplicationRecord
  has_many :ingredientLists
  has_many :ingredients, through: :ingredientLists

  accepts_nested_attributes_for :ingredientLists
end
