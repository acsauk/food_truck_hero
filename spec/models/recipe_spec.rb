require 'rails_helper'

RSpec.describe Recipe, type: :model do

  let(:recipe) { FactoryGirl.build(:recipe) }
  
  it 'has a valid factory' do
    expect(recipe).to be_valid
  end
end
