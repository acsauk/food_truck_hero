class RecipeList < ApplicationRecord
  belongs_to :meal
  belongs_to :recipe
end
