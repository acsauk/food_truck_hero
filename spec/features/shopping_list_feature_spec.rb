require 'rails_helper'

feature 'Shopping Lists' do
  let(:shopping_list) { FactoryBot.create :shopping_list }
  let(:mwrwi) { FactoryBot.create :meal_with_recipes_with_ingredients }

  before do
    sign_in(email: mwrwi.user.email, password: mwrwi.user.password)
    visit root_path
  end

  scenario 'adding a meal to shopping list from meal#show' do
    visit meal_path mwrwi
    click_link 'Add to shopping list'
    expect(page).to have_content "#{mwrwi.name} added to shopping list"
    click_link 'Shopping List'
    mwrwi.ingredients.each do |ingredient|
      expect(page).to have_content "#{ingredient.name}"
    end
  end

  scenario 'see the meals that are on the shopping list' do
    visit meal_path mwrwi
    click_link 'Add to shopping list'
    click_link 'Shopping List'
    expect(page).to have_content mwrwi.name
  end

  scenario 'have a created at date displayed' do
    visit meal_path mwrwi
    click_link 'Add to shopping list'
    click_link 'Shopping List'
    expect(page).to have_content mwrwi.created_at
  end

  scenario 'has a name displayed (if set)' do
    visit meal_path mwrwi
    click_link 'Add to shopping list'
    click_link 'Shopping List'
    expect(page).to have_content shopping_list.name
  end
end
