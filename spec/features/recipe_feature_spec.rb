feature 'Recipes' do
  scenario 'adding recipes - single ingredient' do
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
    expect(page).to have_content 'Ingredients: Ingredient name 20.0 Ingredient unit'
  end

  scenario 'adding recipes - multiple ingredients' do
    visit '/'
    sign_up
    click_link 'New Recipe'
    fill_in 'Title', with: 'Recipe title'
    fill_in 'Instructions', with: 'Recipe instructions'
    fill_in 'name', with: 'Ingredient name'
    fill_in 'amount', with: '20'
    fill_in 'unit', with: 'Ingredient unit'
    fill_in 'name[2]', with: 'Ingredient name 2'
    fill_in 'amount[2]', with: '21'
    fill_in 'unit[2]', with: 'Ingredient unit 2'
    expect(page).to have_content 'Recipe was successfully created'
    expect(page).to have_content 'Title: Recipe title'
    expect(page).to have_content 'Instructions: Recipe instructions'
    expect(page).to have_content 'Ingredient name 20.0 Ingredient unit'
    expect(page).to have_content 'Ingredient name 2 21.0 Ingredient unit 2'
  end
end
