class Recipe < ApplicationRecord
  has_many :ingredientLists
  has_many :ingredients, through: :ingredientLists
  validates_presence_of :title, :instructions
  accepts_nested_attributes_for :ingredientLists, allow_destroy: :true,
                                                  reject_if: :all_blank
end
