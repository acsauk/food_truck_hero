require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  let(:shopping_list) { FactoryBot.create(:shopping_list) }
  let(:mwrwi) { FactoryBot.create(:meal_with_recipes_with_ingredients) }
  let(:slwmwrwi) { FactoryBot.create(:shopping_list_with_meals_with_recipes_with_ingredients) }

  it 'has a valid factory' do
    expect(shopping_list).to be_valid
  end

  it { is_expected.to have_many(:meal_lists) }
  it { is_expected.to have_many(:meals).through(:meal_lists) }


  it { is_expected.to belong_to(:user) }

  it 'can add meals' do
    shopping_list.add_meal mwrwi
    expect(shopping_list.meals.last).to eq mwrwi
  end

  it 'knows the ingredients associated with it' do
    shopping_list.meals << mwrwi
    ingredients = mwrwi.ingredients
    expect(shopping_list.ingredients).to eq ingredients
  end
end
