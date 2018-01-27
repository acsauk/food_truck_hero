class IngredientList < ApplicationRecord
  belongs_to :recipe, optional: true
  belongs_to :ingredient, optional: true

  validates_presence_of :unit, :amount

  def ingredient_attributes=(ingredient_attributes)
    if ingredient_attributes['name']
      new_ingredient = Ingredient.find_or_create_by(name: ingredient_attributes['name'])
      self.ingredient = new_ingredient
    end
  end
end
