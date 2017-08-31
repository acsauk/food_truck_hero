feature 'Recipes' do
  scenario 'adding recipes' do
    puts 'adding recipes'
    visit '/'
    sign_up
    save_and_open_page
    click_link 'New Recipe'
    fill_in 'Title', with: 'Recipe title'
    fill_in 'Instructions', with: 'Recipe instructions'
    fill_in 'ingredient_1', with: 'Ingredient name'
    fill_in 'quantity_1', with: 'Quantity amount'
    fill_in 'unit_1', with: 'Unit type'
    click_button 'Create Recipe'
    expect(page).to have_content 'Recipe was successfully created'
    expect(page).to have_content 'Title: Recipe title'
    expect(page).to have_content 'Instructions: Recipe instructions'
    expect(page).to have_content 'Ingredients: Ingredient name Quantity amount Unit type'
  end
end
