require 'rails_helper'

Rspec.describe Recipe, type: :model do
  it 'has a valid factory' do
    expect(recipe).to be_valid
  end
end
