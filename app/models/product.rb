class Product < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :brand
  validates_presence_of :unit
  validates_presence_of :amount
  validates_presence_of :price_pence

  has_one :ingredient

  monetize :price_pence

  def smu_price
    Money.new(price_pence / amount)
  end
end
