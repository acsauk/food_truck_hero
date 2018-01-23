class IngredientList < ApplicationRecord
  belongs_to :recipe, optional: true
  belongs_to :ingredient, optional: true

  def ingredient_attributes=(ingredient_attributes)

    if ingredient_attributes['name']
      new_ingredient = Ingredient.find_or_create_by(name: ingredient_attributes['name']) do |i|
        i.amount = ingredient_attributes['amount']
        i.unit = ingredient_attributes['unit']
      end
      self.ingredient = new_ingredient
    end
  end
end
