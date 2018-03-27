require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.build(:product) }

  it 'has a valid factory' do
    expect(product).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:brand) }
  it { is_expected.to validate_presence_of(:unit) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to have_many(:ingredients) }

  it 'has a price per smallest measurable unit' do
    product = FactoryBot.build(:product, amount: 100, price: 2.0)
    expected_single_measurable_unit_price = product.price / product.amount
    actual_single_measurable_unit_price = product.smu_price
    expect(actual_single_measurable_unit_price).to eq expected_single_measurable_unit_price
  end
end
