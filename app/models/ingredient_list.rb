class IngredientList < ApplicationRecord
  validates_presence_of :unit, :amount

  belongs_to :recipe, optional: true
  belongs_to :ingredient, optional: true

  accepts_nested_attributes_for :ingredient, allow_destroy: true
end
