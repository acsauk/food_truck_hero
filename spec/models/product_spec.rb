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
  it { is_expected.to validate_presence_of(:price_pence) }
  it { is_expected.to validate_presence_of(:use_by_days) }

  it { is_expected.to have_one(:ingredient) }

  it { is_expected.to monetize(:price) }

  it 'has a price per smallest measurable unit' do
    product = FactoryBot.build(:product, amount: 100, price: 2)
    actual_single_measurable_unit_price = product.smu_price
    expect(actual_single_measurable_unit_price).to eq 2.0
  end

  it 'can handle string values for price attribute' do
    product.price = '£2.50'
    expected_price_value = Money.new(250)
    expect(expected_price_value).to eq product.price
  end

  it 'can handle float values for price attribute' do
    product.price = 2.50
    expected_price_value = Money.new(250)
    expect(expected_price_value).to eq product.price
  end
end
