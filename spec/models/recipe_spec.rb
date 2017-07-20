require 'rails_helper'

RSpec.describe Recipe, type: :model do

  let(:recipe) { FactoryGirl.build(:recipe) }

  it 'has a valid factory' do
    expect(recipe).to be_valid
  end

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:instructions) }
end
