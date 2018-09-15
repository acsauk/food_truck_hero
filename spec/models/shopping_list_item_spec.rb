require 'rails_helper'

RSpec.describe ShoppingListItem, type: :model do
  let(:shopping_list_item) { FactoryBot.build(:shopping_list_item) }
  let(:rwi) { FactoryBot.create(:recipe_with_ingredients) }

  before(:each) do
    shopping_list_item.ingredient = rwi.ingredients.first
  end

  it 'has a valid factory' do
    expect(shopping_list_item).to be_valid
  end

  it { is_expected.to belong_to(:shopping_list) }
  it { is_expected.to have_one(:ingredient) }

  it 'knows the name of ingredient associated with it' do
    expect(shopping_list_item.name).to eq rwi.ingredients.first.name
  end

  it 'knows the unit of ingredient associated with it' do
    expect(shopping_list_item.unit).to eq rwi.ingredients.first.unit
  end

  it 'knows the amount of ingredient associated with it' do
    expect(shopping_list_item.amount).to eq rwi.ingredients.first.amount
  end
end
