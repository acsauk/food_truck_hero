class ShoppingListItem
  include ActiveModel::Model

  attr_accessor :name, :amount, :unit, :purchased
  validates :name, :amount, :unit, presence: true
  validates :purchased, :inclusion => {:in => [true, false]}

end