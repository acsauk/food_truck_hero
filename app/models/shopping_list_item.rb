class ShoppingListItem < ApplicationRecord
  belongs_to :shopping_list
  has_one :ingredient
end
