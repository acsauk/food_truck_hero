require 'rails_helper'

feature 'Meals' do
  let(:rwi) { FactoryBot.create :recipe_with_ingredients }

  before do
    sign_in(email: rwi.user.email, password: rwi.user.password)
    visit root_path
  end

  scenario 'adding a Meal' do
    find("#nav-bar > a[href='#{meals_path}']").click
    click_link 'New Meal'
    fill_in 'Name', with: title
    fill_in 'Portions', with: 6
    select(rwi.title.to_s, from: 'recipe-title').select_option
    click_button 'Create Meal'
    expect(page).to have_content 'Meal was successfully created'
    expect(page).to have_content 'Name: Meal Name'
    expect(page).to have_content 'Portions: 6'
    expect(page).to have_content 'Price per Portion: £20.0'
    rwi.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end
end
