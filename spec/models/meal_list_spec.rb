require 'rails_helper'

RSpec.describe MealList, type: :model do
  let(:shopping_list) { FactoryBot.build(:shopping_list) }
  let(:meal_list) { FactoryBot.build(:meal_list) }
  let(:meal) { FactoryBot.build(:meal) }

  it 'has a valid factory' do
    expect(meal_list).to be_valid
  end

  it { is_expected.to belong_to(:shopping_list) }
  it { is_expected.to belong_to(:meal) }
end
