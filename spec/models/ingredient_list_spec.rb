require 'rails_helper'

RSpec.describe IngredientList, type: :model do
  let(:ingredient_list) { FactoryGirl.build(:ingredient_list) }
  let(:ingredient) { FactoryGirl.build(:ingredient) }

  it 'has a valid factory' do
    expect(ingredient_lists).to be_valid
  end

  it { is_expected.to belong_to(:recipe) }
  it { is_expected.to belong_to(:ingredient) }

  # it 'should return an existing ingredient' do
  #   ingredient_list.ingredient_attributes(name: ingredient.name)
  #
  # end
end
