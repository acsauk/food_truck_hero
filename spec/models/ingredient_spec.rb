require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let(:ingredient) { FactoryBot.create(:ingredient) }
  let(:rwi) { FactoryBot.create(:recipe_with_ingredients) }

  it 'has a valid factory' do
    expect(ingredient).to be_valid
  end

  it { is_expected.to have_many(:recipes).through(:ingredient_lists) }
  it { is_expected.to have_many(:ingredient_lists) }
  it { is_expected.to belong_to(:product).optional }

  it 'has a method to return the amount of ingredient stored in ingredient_list' do
    recipe_ingredient = rwi.ingredients.first
    expected_ingredient_amount = recipe_ingredient.ingredient_lists.find_by_ingredient_id(recipe_ingredient.id).amount
    actual_ingredient_amount = recipe_ingredient.amount
    expect(expected_ingredient_amount).to eq actual_ingredient_amount
  end

  it 'has a method to return the unit of ingredient stored in ingredient_list' do
    recipe_ingredient = rwi.ingredients.first
    expected_ingredient_unit = recipe_ingredient.ingredient_lists.find_by_ingredient_id(recipe_ingredient.id).unit
    actual_ingredient_unit = recipe_ingredient.unit
    expect(expected_ingredient_unit).to eq actual_ingredient_unit
  end

  it 'knows the name of the product associated with it' do
    expect(ingredient.name).to eq ingredient.product.name
  end
end
