require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.build(:product) }

  it 'has a valid factory' do
    expect(product).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:brand) }
  it { is_expected.to validate_presence_of(:size) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to have_many :ingredients }
end
