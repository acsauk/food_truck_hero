require 'rails_helper'
RSpec.describe Meal, type: :model do
  let(:rwi) { FactoryBot.create :recipe_with_ingredients }
  let(:meal) { FactoryBot.create(:meal) }

  it 'has a valid factory' do
    expect(meal).to be_valid
  end

  it { is_expected.to have_many(:recipeLists) }
  it { is_expected.to have_many(:recipes).through(:recipeLists) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:portions) }
  it { is_expected.to validate_presence_of(:price_per_portion) }

  it 'has the total cost of all ingredients associated with the meal' do
    ingredients_price = meal.recipes.first.ingredients.first.product.price
    it { is_expected.to have_attributes(ingredients_cost: ingredients_price) }
  end
end
