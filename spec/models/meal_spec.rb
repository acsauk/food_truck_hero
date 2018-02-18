require 'rails_helper'
RSpec.describe Meal, type: :model do
  let(:meal) { FactoryBot.create(:meal) }

  it 'has a valid factory' do
    expect(meal).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:portions) }
  it { is_expected.to validate_presence_of(:price_per_portion) }
end
