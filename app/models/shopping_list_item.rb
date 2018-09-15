class ShoppingListItem < ApplicationRecord
  belongs_to :shopping_list

  def name
    ingredient.name
  end

  def unit
    ingredient.unit
  end

  def amount
    ingredient.amount
  end
end
