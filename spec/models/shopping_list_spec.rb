require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  let(:shopping_list) { FactoryBot.create(:shopping_list) }
  let(:mwrwi) { FactoryBot.create(:meal_with_recipes_with_ingredients) }
  let(:slwmwrwi) { FactoryBot.create(:shoppingList_with_meals_with_recipes_with_ingredients) }

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

  it 'creates shopping_list_items and associates them with each ingredient of a meal when adding a meal' do
    shopping_list.meals << mwrwi
    shopping_list.create_items_from_meal_ingredients mwrwi

    shopping_list_items = shopping_list.shopping_list_items
    meal_associated_shopping_list = mwrwi.shopping_lists.first
    meal_ingredients = mwrwi.ingredients

    shopping_list_items.each do |item|
      expect(item.shopping_list).to eq shopping_list
    end

    expect(meal_associated_shopping_list).to eq shopping_list

    meal_ingredients.each do |ingredient|
      expect(ingredient.shopping_list_item.shopping_list).to eq shopping_list
    end
  end

  it 'knows the ingredients associated with it' do
    shopping_list.meals << mwrwi
    ingredients = mwrwi.ingredients
    expect(shopping_list.ingredients).to eq ingredients
  end
end
