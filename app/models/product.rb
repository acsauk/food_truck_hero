class Product < ApplicationRecord
  has_many :ingredients

  validates_presence_of :name
  validates_presence_of :brand
  validates_presence_of :size
  validates_presence_of :price
end
