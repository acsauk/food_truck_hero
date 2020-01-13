require 'rails_helper'

feature 'Recipes', js: true do
  let(:rwi) { FactoryBot.create :recipe_with_ingredients, ingredients_count: 3 }

  before {
    sign_in_as(email: rwi.user.email, password: rwi.user.password)
    visit root_path
  }

  let(:product) { FactoryBot.create :product }

  scenario 'adding recipes - multiple ingredients' do
    create_recipe(ingredients_count: 2, product_name: product.name)
    expect(page).to have_content 'Recipe was successfully created'
    expect(page).to have_content 'Recipe title'
    expect(page).to have_content 'Recipe instructions'
    expect(page).to have_content "#{product.name} 20.0 Ingredient unit"
    expect(page).to have_css('div.ingredient', count: 2)
  end

  scenario 'deleting recipes - recipe show view' do
    create_recipe(product_name: product.name)
    click_link 'Delete'
    expect(page).to have_content 'Recipe was successfully destroyed.'
  end

  scenario 'deleting recipes - recipes view' do
    create_recipe(product_name: product.name)
    recipe = Recipe.last
    visit recipes_path
    delete_link = find("a[href='#{recipe_path recipe}']"){ |el| el['data-method'] == 'delete' }
    delete_link.click
    expect(page).not_to have_content delete_link
    expect(page).to have_content 'Recipe was successfully destroyed.'
  end

  scenario 'editing recipe - via recipe#show' do
    create_recipe(ingredients_count: 2, product_name: product.name)
    recipe = Recipe.last
    visit recipes_path
    find('tr', text: recipe.title.to_s).click_link recipe.title.to_s
    click_link 'Edit'
    expect(page).to have_current_path(edit_recipe_path(recipe))
    edit_recipe(recipe)
    expect(page).to have_content 'Recipe title edit'
    expect(page).to have_content 'Recipe instructions edit'
    expect(page).to have_content "#{product.name} 200.0 Grams"
  end

  scenario 'editing recipe - via recipes#index' do
    create_recipe(ingredients_count: 2, product_name: product.name)
    recipe = Recipe.last
    visit recipes_path
    find('tr', text: recipe.title.to_s).click_link 'Edit'
    expect(page).to have_current_path(edit_recipe_path(recipe))
    edit_recipe(recipe)
    expect(page).to have_content 'Recipe title edit'
    expect(page).to have_content 'Recipe instructions edit'
    expect(page).to have_content "#{product.name} 200.0 Grams"
  end

  scenario 'editing recipe - removing ingredient' do
    visit recipes_path
    find('tr', text: rwi.title.to_s).click_link 'Edit'
    expect(page).to have_current_path(edit_recipe_path(rwi))
    expect(page).to have_css('div.ingredient', count: 3)
    edit_recipe_remove_ingredient()
    expect(page).to have_css('div.ingredient', count: 2)
  end
end
