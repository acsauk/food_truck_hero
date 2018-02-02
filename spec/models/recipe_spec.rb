require 'rails_helper'

RSpec.describe Recipe, type: :model do

  let(:recipe) { FactoryBot.create(:recipe) }
  let(:ingredientList) { FactoryBot.create(:ingredientList) }
  let(:rwi) { FactoryBot.create(:recipe_with_ingredients) }

  it 'has a valid factory' do
    expect(recipe).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:instructions) }
  it { is_expected.to have_many(:ingredients).through(:ingredientLists) }
  it { is_expected.to have_many(:ingredientLists) }
  it { is_expected.to accept_nested_attributes_for(:ingredientLists) }

  it 'deletes associated IngredientLists when destroyed' do
    expect { rwi.destroy }.to change(IngredientList, :count).by(-IngredientList.all.size)
  end

  # Instantiate as passing into block in test is lazily evaluated
  before { rwi }

  it 'does not delete associated Ingredient when destroyed' do
    expect { rwi.destroy }.to_not change(Ingredient, :count)
  end
end
