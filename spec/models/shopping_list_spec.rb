require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  let(:shopping_list) { FactoryBot.create(:shopping_list) }
  let(:mwrwi) {
    FactoryBot.create(
      :meal_with_recipes_with_ingredients,
      ingredients_count: 2,
      recipes_count: 3
    )
  }

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

  it 'can split ingredients into arrays based on ingredient id' do
    shopping_list = mwrwi.user.shopping_list
    shopping_list.meals << mwrwi

    expected_ingredient_ids = shopping_list.ingredients.uniq.collect { |i| i.id }

    actual_ingredients = shopping_list.split_ingredients_by_id
    expect(actual_ingredients.length).to eq 2

    actual_ingredient_ids = []

    actual_ingredients.each_value do |array|
      actual_ingredient_ids << array.collect { |ingredient| ingredient.id }
    end

    expect(expected_ingredient_ids).to eq actual_ingredient_ids.flatten.uniq
  end

  it 'accumulates duplicate ingredients amounts and converts to single ShoppingListItem' do
    shopping_list = mwrwi.user.shopping_list
    shopping_list.meals << mwrwi
    ingredients = shopping_list.ingredients
    split_ingredients = shopping_list.split_ingredients_by_id
        
    expected_shopping_list_item = ShoppingListItem.new(
      name: ingredients.first.name,
      amount: ingredients.first.amount * split_ingredients.values.first.length,
      unit: ingredients.first.unit
      # purchased: false
    )
    
    actual_shopping_list_item = shopping_list.convert_identical_ingredients_to_shopping_list_item(split_ingredients.values.first)

    expect(actual_shopping_list_item.name).to eq expected_shopping_list_item.name
    expect(actual_shopping_list_item.amount).to eq expected_shopping_list_item.amount
    expect(actual_shopping_list_item.unit).to eq expected_shopping_list_item.unit
    expect(actual_shopping_list_item.purchased).to eq expected_shopping_list_item.purchased
  end
end
