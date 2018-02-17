class IngredientList < ApplicationRecord
  belongs_to :recipe, optional: true
  belongs_to :ingredient, optional: true

  validates_presence_of :unit, :amount

  def ingredient_attributes=(attributes)
    if attributes['name']
      new_ingredient = Ingredient.find_or_create_by(name: attributes['name'], product_id: attributes['product_id'])
      self.ingredient = new_ingredient
    end
  end
end
