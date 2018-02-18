require 'rails_helper'

feature 'Meals' do
  let(:recipe) { FactoryBot.create :recipe }

  scenario 'adding a Meal' do
    login_user
    visit root_path
    find("#nav-bar > a[href='#{meals_path}']").click
    click_link 'New Meal'
    fill_in 'Name', with: title
    fill_in 'Portions', with: 6
    select(recipe.title.to_s, from: 'recipe-name').select_option
    click_button 'Create Meal'
    expect(page).to have_content 'Meal was successfully created'
    expect(page).to have_content 'Name: Meal Name'
    expect(page).to have_content 'Portions: 6'
    expect(page).to have_content 'Price per Portion: £20.0'
  end
end
