require 'rails_helper'

feature 'Pagination' do
  let(:user) { FactoryBot.create :user }

  before(:each) do
    sign_in_as(email: user.email, password: user.password)
    visit root_path
  end
  
  scenario 'items per page is set to 15' do
    16.times { FactoryBot.create :product }
    click_link 'Products'
    within('#products') do
      expect(all('tr').count).to eq(15)
    end
  end

  scenario 'all items are rendered' do
    16.times { FactoryBot.create :product }
    click_link 'Products'
    click_link 'Next'
    within('#products') do
      expect(all('tr').count).to eq(1)
    end
  end
end