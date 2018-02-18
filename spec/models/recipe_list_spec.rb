require 'rails_helper'

RSpec.describe RecipeList, type: :model do
  let(:recipe) { FactoryBot.build(:recipe) }
  let(:recipeList) { FactoryBot.build(:recipeList) }
  let(:meal) { FactoryBot.build(:meal) }

  it 'has a valid factory' do
    expect(ingredientList).to be_valid
  end

  it { is_expected.to belong_to(:recipe) }
  it { is_expected.to belong_to(:meal) }
end
