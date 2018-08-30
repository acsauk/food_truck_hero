require 'rails_helper'

xfeature 'Meals' do
  let(:rwi) { FactoryBot.create :recipe_with_ingredients }

  before do
    sign_in(email: rwi.user.email, password: rwi.user.password)
    visit root_path
  end

  scenario 'adding a Meal' do
    create_meal(recipe_title: rwi.title.to_s)
    meal = Meal.last
    expect(page).to have_content 'Meal was successfully created'
    expect(page).to have_content "Name: #{meal.name}"
    expect(page).to have_content "Portions: #{meal.portions}"
    expect(page).to have_content "Price per portion: £#{meal.price_per_portion}"
    rwi.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end

  scenario 'viewing a Meal' do
    create_meal(recipe_title: rwi.title.to_s)
    meal = Meal.last
    visit meal_path meal
    expect(page).to have_content "Name: #{meal.name}"
    expect(page).to have_content "Portions: #{meal.portions}"
    expect(page).to have_content "Price per portion: £#{meal.price_per_portion}"
    rwi.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end

  scenario 'editing meal - via meal#show' do
    create_meal(recipe_title: rwi.title.to_s)
    rwi2 = FactoryBot.create :recipe_with_ingredients
    meal = Meal.last
    visit meals_path
    find('tr', text: meal.name.to_s).click_link meal.name.to_s
    click_link 'Edit'
    expect(page).to have_current_path(edit_meal_path(meal))
    edit_meal(meal, rwi2)
    expect(page).to have_content "Name: #{meal.name}"
    expect(page).to have_content "Portions: #{meal.portions}"
    expect(page).to have_content "Price per portion: £#{meal.price_per_portion}"
    rwi.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end

  scenario 'editing meal - via meals#index' do
    create_meal(recipe_title: rwi.title.to_s)
    rwi2 = FactoryBot.create :recipe_with_ingredients
    meal = Meal.last
    visit meals_path
    find('tr', text: meal.name.to_s).click_link 'Edit'
    expect(page).to have_current_path(edit_meal_path(meal))
    edit_meal(meal, rwi2)
    expect(page).to have_content "Name: #{meal.name}"
    expect(page).to have_content "Portions: #{meal.portions}"
    expect(page).to have_content "Price per portion: £#{meal.price_per_portion}"
    rwi.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end

  scenario 'editing recipe updates a meals ingredients displayed' do
    create_meal(recipe_title: rwi.title.to_s)
    visit recipe_path rwi
    click_link 'Edit'
    edit_recipe(rwi)
    visit meal_path Meal.last
    rwi.ingredients.each do |i|
      expect(page).to have_content i.name.to_s
    end
  end

  scenario 'deleting a meal via meal#show' do
    create_meal(recipe_title: rwi.title.to_s)
    visit meal_path Meal.last
    click_link 'Delete'
    expect(page).to have_content 'Meal was successfully destroyed.'
  end

  scenario 'deleting a meal via meals#index' do
    create_meal(recipe_title: rwi.title.to_s)
    meal = Meal.last
    visit meals_path
    expect(page).to have_link 'Delete'
    delete_link = find("a[href='#{meal_path meal}']"){ |el| el['data-method'] == 'delete' }
    delete_link.click
    expect(page).not_to have_content delete_link
    expect(page).to have_content 'Meal was successfully destroyed.'
  end

  scenario 'viewing the cost of all ingredients for a meal' do
    create_meal(recipe_title: rwi.title.to_s)
    meal = Meal.last
    visit meal_path meal
    expect(page).to have_content "Ingredients cost: £#{meal.ingredients_cost}"
  end

  scenario 'viewing the cost per portion for a meal' do
    create_meal(recipe_title: rwi.title.to_s)
    meal = Meal.last
    visit meal_path meal
    expect(page).to have_content "Cost per portion: £#{meal.cost_per_portion}"
  end

  scenario 'viewing the margin of the meal' do
    create_meal(recipe_title: rwi.title.to_s)
    meal = Meal.last
    visit meal_path meal
    expect(page).to have_content "Margin: #{meal.margin}%"
  end
end
