require 'rails_helper'

RSpec.describe Recipe, type: :model do

  let(:recipe) { FactoryBot.create(:recipe) }
  let(:ingredient_list) { FactoryBot.create(:ingredient_list) }
  let(:rwi) { FactoryBot.create(:recipe_with_ingredients) }

  it 'has a valid factory' do
    expect(recipe).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:instructions) }

  it { is_expected.to have_many(:ingredient_lists) }
  it { is_expected.to have_many(:ingredients).through(:ingredient_lists) }

  it { is_expected.to have_many(:recipe_lists) }
  it { is_expected.to have_many(:meals).through(:recipe_lists) }

  it { is_expected.to belong_to(:user).optional }

  it { is_expected.to accept_nested_attributes_for(:ingredient_lists) }

it 'can have multiple ingredients associated with a recipe' do
  ingredients_count = 4
  four_ingredient_recipe = FactoryBot.create:recipe_with_ingredients,
                                            ingredients_count: ingredients_count
  expect(four_ingredient_recipe.ingredients.size).to eq ingredients_count
end

  it 'deletes associated ingredient_lists when destroyed' do
    expect { rwi.destroy }.to change(rwi.ingredient_lists, :count).by(-rwi.ingredient_lists.all.size)
  end

  # Instantiate as passing into block in test is lazily evaluated
  before { rwi }

  it 'does not delete associated Ingredient when destroyed' do
    expect { rwi.destroy }.to_not change(Ingredient, :count)
  end
end
