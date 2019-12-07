class User < ApplicationRecord
  validates_presence_of :email, :first_name, :last_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Execute this callback after an record is saved only on create
  after_save :create_and_associate_shopping_list, on: :create

  has_many :recipes, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_one :shopping_list

  private

  def create_and_associate_shopping_list
    self.shopping_list = ShoppingList.create
  end
end
