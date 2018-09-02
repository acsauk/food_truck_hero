require 'rails_helper'

feature 'Shopping Lists' do
  let(:shopping_list) { FactoryBot.create :shopping_list }
  let(:mwrwi) { FactoryBot.create :shopping_list }
  let(:rwi) { FactoryBot.create :recipe_with_ingredients }

  scenario 'adding a meal to shopping list' do
    # visit the path of a meal
    create_meal(recipe_title: rwi.title.to_s)
    meal = Meal.last
    visit meal_path meal
    # click add to shopping list
    click_link 'Add to shopping list'
    # visit shopping_list
    click_link 'Shopping List'
    # expect page to have the ingredients associated with meal
    meal.ingredients.each do |ingredient|
      expect(page).to have_content ingredient.name
    end
  end
end
