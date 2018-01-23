require 'rails_helper'

RSpec.describe IngredientList, type: :model do
  let(:ingredient_lists) { FactoryGirl.build(:ingredient_list) }

  it 'has a valid factory' do
    expect(ingredient_lists).to be_valid
  end

  it { is_expected.to belong_to(:recipe) }
  it { is_expected.to belong_to(:ingredient) }
end
