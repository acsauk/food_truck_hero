def create_recipe(title: 'Recipe title',
                  instructions: 'Recipe instructions',
                  ingredients_count: 2,
                  ingredient_name: 'Ingredient name',
                  ingredient_amount: 20,
                  ingredient_unit: 'Ingredient unit')
  click_link 'New Recipe'
  fill_in 'Title', with: title
  fill_in 'Instructions', with: instructions
  count = 0
  until count == ingredients_count
    fill_in "name-#{count}", with: "#{ingredient_name} #{count + 1}"
    fill_in "amount-#{count}", with: ingredient_amount + count
    fill_in "unit-#{count}", with: "#{ingredient_unit} #{count + 1}"
    count += 1
  end
  click_button 'Create Recipe'
end
