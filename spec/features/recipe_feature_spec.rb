feature 'Recipes' do
  scenario 'adding recipes' do
    puts 'adding recipes'
    visit '/'
    sign_up
    click_link 'Add Recipe'
    fill_in 'Title', with: 'Recipe title'
    fill_in 'Instructions', with: 'Recipe instructions'
    fill_in '#ingredient-1', with: 'Ingredient name'
    fill_in '#quantity-1', with: 'Quantity amount'
    fill_in '#unit-1', with: 'Unit type'
    click_button 'Create recipe'
    expect(page).to have_content 'Recipe title recipe successfully created'
    expect(page).to have_link 'Recipe title'
    expect(current_path).to eq '/recipes'
  end
end
