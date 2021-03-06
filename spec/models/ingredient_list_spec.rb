require 'rails_helper'

RSpec.describe IngredientList, type: :model do
  let(:recipe) { FactoryBot.build(:recipe) }
  let(:ingredient_list) { FactoryBot.create(:ingredient_list) }
  let(:ingredient) { FactoryBot.build(:ingredient) }

  # let(:valid_attributes) {
  #   {
  #     title: 'A recipe title',
  #     instructions: 'Some instructions on making the recipe',
  #     ingredientLists_attributes:[
  #       [amount: '200', unit: 'grams'],
  #       ingredient_attributes: [name: 'Ingredient Name']
  #     ]
  #   }
  # }

  it 'has a valid factory' do
    expect(ingredient_list).to be_valid
  end

  it { is_expected.to belong_to(:recipe).optional }
  it { is_expected.to belong_to(:ingredient).optional }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:unit) }

  # it 'should return an existing ingredient' do
  #   actual = recipe.create(valid_attributes)
  #   expect(actual).to_eq ingredient.name
  # end
end
