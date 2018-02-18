require 'rails_helper'

RSpec.describe Meal, type: :model do
  let(:meal) { FactoryBot.create(:meal) }

  it 'has a valid factory' do
    expect(recipe).to be_valid
  end
end
