require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  let(:shopping_list) { FactoryBot.build(:shopping_list) }
  let(:mwrwi) { FactoryBot.build(:meal_with_recipes_with_ingredients) }
  let(:slwmwrwi) { FactoryBot.build(:shoppingList_with_meals_with_recipes_with_ingredients) }

  it 'has a valid factory' do
    expect(shopping_list).to be_valid
  end

  it { is_expected.to have_many(:meal_lists) }
  it { is_expected.to have_many(:meals).through(:meal_lists) }

  it { is_expected.to have_many(:shopping_list_items) }

  it { is_expected.to belong_to(:user) }

  it 'can add meals' do
    shopping_list.add_meal mwrwi
    expect(shopping_list.meals.last).to eq mwrwi
  end

  it 'creates shopping_list_items when adding a meal' do
    shopping_list.meals << mwrwi
    shopping_list.create_items_from_ingredients mwrwi
    binding.irb
    ingredients = shopping_list.meals.ingredients.pluck(:id)
    items = shopping_list.shopping_list_items.pluck(:ingredient_id)
    expect(ingredients).to eq items
  end
end
