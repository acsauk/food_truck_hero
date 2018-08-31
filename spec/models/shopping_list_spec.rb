require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  let(:shoppingList) { FactoryBot.build(:shoppingList) }

  it 'has a valid factory' do
    expect(shoppingList).to be_valid
  end

  it { is_expected.to have_many(:mealLists) }
  it { is_expected.to have_many(:meals).through(:mealLists) }
end
