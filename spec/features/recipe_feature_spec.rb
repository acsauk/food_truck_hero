feature 'Recipes' do
  scenario 'adding recipes - multiple ingredients' do
    visit '/'
    sign_up
    create_recipe(ingredients_count: 2)
    expect(page).to have_content 'Recipe was successfully created'
    expect(page).to have_content 'Title: Recipe title'
    expect(page).to have_content 'Instructions: Recipe instructions'
    expect(page).to have_content 'Ingredient name 1 20.0 Ingredient unit 1'
    expect(page).to have_content 'Ingredient name 2 21.0 Ingredient unit 2'
  end
end
