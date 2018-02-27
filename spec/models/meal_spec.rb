require 'rails_helper'
RSpec.describe Meal, type: :model do
  let(:meal) { FactoryBot.create(:meal) }
  let(:meal_with_recipes_with_ingredients) { FactoryBot.create(:meal_with_recipes_with_ingredients) }

  it 'has a valid factory' do
    expect(meal).to be_valid
  end

  it { is_expected.to have_many(:recipeLists) }
  it { is_expected.to have_many(:recipes).through(:recipeLists) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:portions) }
  it { is_expected.to validate_presence_of(:price_per_portion) }

  it 'has the total cost of all ingredients associated with the meal' do
    ingredients_cost = meal_with_recipes_with_ingredients.ingredients_cost
    expect(meal_with_recipes_with_ingredients).to have_attributes(ingredients_cost: ingredients_cost)
  end
end
