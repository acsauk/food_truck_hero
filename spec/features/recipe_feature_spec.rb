feature 'Recipes' do
  before {
    visit root_path
    sign_up
  }

  scenario 'adding recipes - multiple ingredients' do
    create_recipe(ingredients_count: 2)
    expect(page).to have_content 'Recipe was successfully created'
    expect(page).to have_content 'Title: Recipe title'
    expect(page).to have_content 'Instructions: Recipe instructions'
    expect(page).to have_content 'Ingredient name 1 20.0 Ingredient unit 1'
    expect(page).to have_content 'Ingredient name 2 21.0 Ingredient unit 2'
  end

  scenario 'deleting recipes - recipe show view' do
    recipe = FactoryBot.create :recipe
    visit recipe_path recipe
    click_link 'Delete'
    expect(page).to have_content 'Recipe was successfully destroyed.'
  end

  scenario 'deleting recipes - recipes view' do
    recipe = FactoryBot.create :recipe
    visit recipes_path
    delete_link = find("a[href='#{recipe_path recipe}']"){ |el| el['data-method'] == 'delete' }
    delete_link.click
    expect(page).not_to have_content delete_link
    expect(page).to have_content 'Recipe was successfully destroyed.'
  end

  scenario 'viewing recipes' do
    create_recipe(ingredients_count: 2)
    visit recipe_path Recipe.last
    expect(page).to have_content 'Title: Recipe title'
    expect(page).to have_content 'Instructions: Recipe instructions'
    expect(page).to have_content 'Ingredient name 1 20.0 Ingredient unit 1'
    expect(page).to have_content 'Ingredient name 2 21.0 Ingredient unit 2'
  end

  scenario 'editing recipe - via recipe#show' do
    create_recipe(ingredients_count: 2)
    recipe = Recipe.last
    visit recipe_path recipe
    click_link 'Edit'
    expect(page).to have_current_path(edit_recipe_path(recipe))
    edit_recipe(recipe)
    expect(page).to have_content 'Title: Recipe title edit'
    expect(page).to have_content 'Instructions: Recipe instructions edit'
    expect(page).to have_content 'name edit 1 40.0 unit edit 1'
    expect(page).to have_content 'name edit 2 42.0 unit edit 2'
  end

  scenario 'editing recipe - via recipes#index' do
    create_recipe(ingredients_count: 2)
    recipe = Recipe.last
    visit recipes_path
    find('tr', text: recipe.title.to_s).click_link 'Edit'
    expect(page).to have_current_path(edit_recipe_path(recipe))
    edit_recipe(recipe)
    expect(page).to have_content 'Title: Recipe title edit'
    expect(page).to have_content 'Instructions: Recipe instructions edit'
    expect(page).to have_content 'name edit 1 40.0 unit edit 1'
    expect(page).to have_content 'name edit 2 42.0 unit edit 2'
  end
end
