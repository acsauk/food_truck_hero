require 'rails_helper'

RSpec.describe Meal, type: :model do
  let(:meal) { FactoryBot.create(:meal) }
  let(:mwrwi_two_pound_product) {
    FactoryBot.create(
      :meal_with_recipes_with_ingredients,
      :two_pound_product,
      recipes_count: 3,
      ingredients_count: 1
    )
  }

  it 'has a valid factory' do
    expect(meal).to be_valid
  end

  it { is_expected.to have_many(:recipe_lists) }
  it { is_expected.to have_many(:recipes).through(:recipe_lists) }
  it { is_expected.to belong_to(:user).optional }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:portions) }
  it { is_expected.to validate_presence_of(:price_per_portion_pence) }

  it { is_expected.to monetize(:price_per_portion) }

  it 'knows its total cost of all associated ingredients' do
    # Meal has three recipes, each with one ingredient linked to a product with
    # an amount of 100 and price of 2 pounds.

    actual_ingredients_cost = mwrwi_two_pound_product.ingredients_cost
    expect(mwrwi_two_pound_product).to have_attributes(ingredients_cost: actual_ingredients_cost)
    expect(actual_ingredients_cost.fractional).to eq 120
  end

  it 'can handle string values for price_per_portion attribute' do
    meal.price_per_portion = '£2.50'
    expected_price_value = Money.new(250)
    expect(meal.price_per_portion).to eq expected_price_value
  end

  it 'can handle float values for price_per_portion attribute' do
    meal.price_per_portion = 2.50
    expected_price_value = Money.new(250)
    expect(meal.price_per_portion).to eq expected_price_value
  end

  it 'knows its cost per portion' do
    expected_cost_per_portion =
      mwrwi_two_pound_product.ingredients_cost / mwrwi_two_pound_product.portions

    actual_cost_per_portion = mwrwi_two_pound_product.cost_per_portion
    expect(actual_cost_per_portion).to eq expected_cost_per_portion
  end

  it 'knows its margin' do
    expected_meal_margin = (
        mwrwi_two_pound_product.profit_per_portion / Money.new(mwrwi_two_pound_product.price_per_portion) * 100
    )

    actual_meal_margin = mwrwi_two_pound_product.margin
    expect(actual_meal_margin).to eq expected_meal_margin
  end

  it 'knows its ingredients' do
    expected_ingredients = [
      mwrwi_two_pound_product.recipes.first.ingredients.first,
      mwrwi_two_pound_product.recipes.second.ingredients.first,
      mwrwi_two_pound_product.recipes.third.ingredients.first
    ]

    actual_ingredients = mwrwi_two_pound_product.ingredients
    expect(actual_ingredients).to eq expected_ingredients
  end
end
