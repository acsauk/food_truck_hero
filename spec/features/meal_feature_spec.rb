require 'rails_helper'

feature 'Meals' do
  let(:rwi) { FactoryBot.create :recipe_with_ingredients }

  before do
    sign_in_as(email: rwi.user.email, password: rwi.user.password)
    visit root_path
  end

  scenario 'adding a Meal' do
    visit meals_path
    click_link 'New Meal'
    fill_in 'Name', with: 'The meal name'
    fill_in 'Portions', with: '27'
    fill_in :meal_price_per_portion, with: '4.78'
    select(rwi.title, from: 'recipe-title').select_option
    click_button 'Create Meal'
    expect(page).to have_content 'Meal was successfully created'
    expect(page).to have_content 'The meal name'
    expect(page).to have_content '27'
    expect(page).to have_content '£4.78'
  end

  scenario 'viewing a Meal' do
    meal = FactoryBot.create :meal_with_recipes_with_ingredients
    visit meal_path meal
    expect(page).to have_content meal.name.to_s
    expect(page).to have_content meal.portions.to_s
    expect(page).to have_content "£#{meal.price_per_portion}"
    meal.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end

  scenario 'editing meal - via meal#show' do
    meal = FactoryBot.create :meal_with_recipes_with_ingredients
    new_recipe = FactoryBot.create :recipe_with_ingredients
    visit meals_path
    find('tr', text: meal.name.to_s).click_link meal.name.to_s
    click_link 'Edit'
    expect(page).to have_current_path(edit_meal_path(meal))
    edit_meal(meal, new_recipe)
    expect(page).to have_content meal.name.to_s
    expect(page).to have_content meal.portions.to_s
    expect(page).to have_content "£#{meal.price_per_portion}"
    new_recipe.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end

  scenario 'editing meal - via meals#index' do
    meal = FactoryBot.create :meal_with_recipes_with_ingredients
    new_recipe = FactoryBot.create :recipe_with_ingredients
    visit meals_path
    find('tr', text: meal.name.to_s).click_link 'Edit'
    expect(page).to have_current_path(edit_meal_path(meal))
    edit_meal(meal, new_recipe)
    expect(page).to have_content meal.name.to_s
    expect(page).to have_content meal.portions.to_s
    expect(page).to have_content "£#{meal.price_per_portion}"
    new_recipe.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end

  scenario 'editing recipe updates a meals ingredients displayed' do
    meal = FactoryBot.create :meal_with_recipes_with_ingredients
    visit edit_recipe_path meal.recipes.first
    edit_recipe(meal.recipes.first)
    visit meal_path meal
    meal.recipes.first.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end

  scenario 'deleting a meal via meal#show' do
    meal = FactoryBot.create :meal
    visit meal_path meal
    click_link 'Delete'
    expect(page).to have_content 'Meal was successfully destroyed.'
  end

  scenario 'deleting a meal via meals#index' do
    meal = FactoryBot.create :meal
    visit meals_path
    delete_link = find("a[href='#{meal_path meal}']") { |el| el['data-method'] == 'delete' }
    delete_link.click
    expect(page).to have_no_content delete_link
    expect(page).to have_content 'Meal was successfully destroyed.'
  end

  scenario 'viewing the cost of all ingredients for a meal' do
    meal = FactoryBot.create :meal_with_recipes_with_ingredients
    visit meal_path meal
    expect(page).to have_content "£#{meal.ingredients_cost}"
  end

  scenario 'viewing the cost per portion for a meal' do
    meal = FactoryBot.create :meal_with_recipes_with_ingredients
    visit meal_path meal
    expect(page).to have_content "£#{meal.cost_per_portion}"
  end

  scenario 'viewing the margin of the meal' do
    meal = FactoryBot.create :meal_with_recipes_with_ingredients
    visit meal_path meal
    expect(page).to have_content "#{meal.margin} %"
  end
end
