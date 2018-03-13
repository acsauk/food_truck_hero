require 'rails_helper'
RSpec.describe Meal, type: :model do
  let(:meal) { FactoryBot.create(:meal) }
  let(:mwrwi_two_pound_product) { FactoryBot.create(:meal_with_recipes_with_ingredients,
                                                    :two_pound_product,
                                                    recipes_count: 3,
                                                    ingredients_count: 1) }

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
    # Meal has three recipes, each with one ingredient linked to a product that costs 2 pounds
    ingredients_cost = mwrwi_two_pound_product.ingredients_cost
    expect(mwrwi_two_pound_product).to have_attributes(ingredients_cost: ingredients_cost)
    expect(ingredients_cost).to eq 6.0
  end
end
