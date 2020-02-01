class Product < ApplicationRecord
  validates_presence_of :name, :brand, :unit, :amount, :price_pence, :use_by_days

  has_one :ingredient

  monetize :price_pence

  def smu_price
    price_pence / amount
  end
end
