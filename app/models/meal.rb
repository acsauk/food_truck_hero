class Meal < ApplicationRecord
  has_many :recipeLists
  has_many :recipes, through: :recipeLists

  belongs_to :user

  accepts_nested_attributes_for :recipeLists

  validates_presence_of :name
  validates_presence_of :portions
  validates_presence_of :price_per_portion
end
