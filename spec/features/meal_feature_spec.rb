require 'rails_helper'

feature 'Meals' do
  let(:rwi) { FactoryBot.create :recipe_with_ingredients }

  before do
    sign_in(email: rwi.user.email, password: rwi.user.password)
    visit root_path
  end

  scenario 'adding a Meal' do
    create_meal(recipe_title: rwi.title.to_s)
    expect(page).to have_content 'Meal was successfully created'
    expect(page).to have_content 'Name: Meal name'
    expect(page).to have_content 'Portions: 6'
    expect(page).to have_content 'Price per portion: £3.5'
    rwi.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end

  scenario 'viewing a Meal' do
    create_meal(recipe_title: rwi.title.to_s)
    visit meal_path Meal.last
    expect(page).to have_content 'Name: Meal name'
    expect(page).to have_content 'Portions: 6'
    expect(page).to have_content 'Price per portion: £3.5'
    rwi.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end
end
