class Product < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :brand
  validates_presence_of :unit
  validates_presence_of :amount
  validates_presence_of :price_pence

  has_many :ingredients

  def smu_price
    price_pence / amount
  end
end
