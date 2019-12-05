class IngredientList < ApplicationRecord
  belongs_to :recipe, optional: true
  belongs_to :ingredient, optional: true

  validates_presence_of :unit, :amount

  accepts_nested_attributes_for :ingredient, allow_destroy: true
end
