require 'rails_helper'

RSpec.describe ShoppingListItem, type: :model do
  let(:shopping_list_item) { FactoryBot.build(:shopping_list_item) }

  it 'has a valid factory' do
    expect(shopping_list_item).to be_valid
  end

  it { is_expected.to belong_to(:shopping_list) }
end
