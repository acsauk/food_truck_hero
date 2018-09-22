class Ingredient < ApplicationRecord
  has_many :ingredient_lists
  has_many :recipes, through: :ingredient_lists

  belongs_to :product, optional: true

  validates_presence_of :product_id, presence: true

  def amount
    ingredient_lists.find_by_ingredient_id(id).amount
  end

  def unit
    ingredient_lists.find_by_ingredient_id(id).unit
  end

  def name
    product.name
  end
end
