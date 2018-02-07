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

def edit_recipe(recipe)
  fill_in 'Title', with: "#{recipe.title} edit"
  fill_in 'Instructions', with: "#{recipe.instructions} edit"
  count = 0
  until count == recipe.ingredients.size
    fill_in "name-#{count}", with: "#{recipe.ingredients[count].name} #{count + 1} edit"
    fill_in "amount-#{count}", with: recipe.ingredientLists[count].amount + count + 1
    fill_in "unit-#{count}", with: "#{recipe.ingredientLists[count].unit} #{count + 1} edit"
    count += 1
  end
  click_button 'Update Recipe'
end
