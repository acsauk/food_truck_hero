class User < ApplicationRecord
  validates_presence_of :email, :first_name, :last_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Execute this callback after an record is saved only on create
  after_save :create_and_associate_initial_shopping_list, on: :create

  has_many :recipes, dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :shopping_lists

  private

  def create_and_associate_initial_shopping_list
    shopping_lists << ShoppingList.create
  end
end
