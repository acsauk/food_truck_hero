require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it { is_expected.to have_many(:recipes) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end
end
