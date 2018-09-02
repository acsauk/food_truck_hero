class ShoppingList < ApplicationRecord
  has_many :meal_lists
  has_many :meals, through: :meal_lists
  has_many :shopping_list_items
  belongs_to :user, optional: true
end
