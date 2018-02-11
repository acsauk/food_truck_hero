class Recipe < ApplicationRecord
  has_many :ingredientLists, dependent: :destroy
  has_many :ingredients, through: :ingredientLists
  belongs_to :user

  accepts_nested_attributes_for :ingredientLists

  validates_presence_of :instructions, :title
end
