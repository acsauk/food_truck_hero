feature 'Recipes' do
  scenario 'adding recipes' do
    puts 'adding recipes'
    visit '/'
    sign_up
    click_link 'New Recipe'
    fill_in 'Title', with: 'Recipe title'
    fill_in 'Instructions', with: 'Recipe instructions'
    fill_in 'name', with: 'Ingredient name'
    fill_in 'amount', with: '20'
    fill_in 'unit', with: 'Ingredient unit'
    click_button 'Create Recipe'
    expect(page).to have_content 'Recipe was successfully created'
    expect(page).to have_content 'Title: Recipe title'
    expect(page).to have_content 'Instructions: Recipe instructions'
    expect(page).to have_content 'Ingredients: Ingredient name 20 Ingredient unit'
  end
end
