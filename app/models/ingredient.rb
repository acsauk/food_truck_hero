class Ingredient < ApplicationRecord
  has_many :ingredientLists
  has_many :recipes, through: :ingredientLists
  belongs_to :product, optional: true
  belongs_to :shopping_list_item, optional: true

  validates_presence_of :name, presence: true
  validates_presence_of :product_id, presence: true

  def amount
    ingredientLists.find_by_ingredient_id(id).amount
  end

  def unit
    ingredientLists.find_by_ingredient_id(id).unit
  end
end
