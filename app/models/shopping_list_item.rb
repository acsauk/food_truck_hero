class ShoppingListItem
  include ActiveModel::Model
  include ActiveModelAttributes

  attribute :name, :string
  attribute :amount, :integer
  attribute :unit, :string
  attribute :purchased, :boolean, default: false

  validates :name, :amount, :unit, presence: true
  validates :purchased, inclusion: { in: [true, false] }
end