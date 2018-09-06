require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  let(:shopping_list) { FactoryBot.build(:shopping_list) }
  let(:meal) { FactoryBot.build(:meal) }

  it 'has a valid factory' do
    expect(shopping_list).to be_valid
  end

  it { is_expected.to have_many(:meal_lists) }
  it { is_expected.to have_many(:meals).through(:meal_lists) }

  it { is_expected.to have_many(:shopping_list_items) }

  it { is_expected.to belong_to(:user) }

  it 'can add meals' do
    shopping_list.add_meal meal
    expect(shopping_list.meals.last).to eq meal
  end

  it 'is not valid with two of the same meal' do
    2.times { shopping_list.add_meal(meal) }
    expect(shopping_list).to_not be_valid
  end
end
