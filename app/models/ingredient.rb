class Ingredient < ApplicationRecord
  validates_presence_of :name, :amount, :unit
end
