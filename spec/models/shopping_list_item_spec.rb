require 'rails_helper'

RSpec.describe ShoppingListItem, type: :model do
    include ActiveModel::Lint::Tests
  let(:shopping_list_item) {FactoryBot.build(:shopping_list_item)}
  
  it 'has a valid factory' do
    expect(shopping_list_item).to be_valid
  end
end