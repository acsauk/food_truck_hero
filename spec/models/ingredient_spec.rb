require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let(:ingredient) { FactoryBot.build(:ingredient) }

  it 'has a valid factory' do
    expect(ingredient).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:recipes).through(:ingredientLists) }
  it { is_expected.to have_many(:ingredientLists) }
end
