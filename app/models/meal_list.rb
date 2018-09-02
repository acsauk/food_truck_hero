class MealList < ApplicationRecord
  belongs_to :meal,          optional: true
  belongs_to :shopping_list, optional: true
end
