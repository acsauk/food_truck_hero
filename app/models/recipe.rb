class Recipe < ApplicationRecord
  has_many :recipe_lists
  has_many :meals, through: :recipe_lists

  has_many :ingredient_lists, inverse_of: :recipe, dependent: :destroy
  has_many :ingredients, through: :ingredient_lists

  belongs_to :user, optional: true

  accepts_nested_attributes_for :ingredient_lists, allow_destroy: true

  validates_presence_of :instructions, :title
end
