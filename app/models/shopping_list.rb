class ShoppingList < ApplicationRecord
  has_many :meal_lists
  has_many :meals, through: :meal_lists
  has_many :shopping_list_items
  belongs_to :user, optional: true

  validate :associated_meals_must_be_unique

  def add_meal(meal)
    meals << meal
  end

  private

  def associated_meals_must_be_unique
    return unless meals.length > meals.distinct.length
    errors.add(:shopping_list, "You can't add the same meal twice")
  end
end
