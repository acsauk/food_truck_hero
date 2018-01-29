require 'rails_helper'

RSpec.describe Recipe, type: :model do

  let(:recipe) { FactoryBot.build(:recipe) }

  it 'has a valid factory' do
    expect(recipe).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:instructions) }
  it { is_expected.to have_many(:ingredients).through(:ingredientLists) }
  it { is_expected.to have_many(:ingredientLists) }
  it { is_expected.to accept_nested_attributes_for(:ingredientLists) }
end
