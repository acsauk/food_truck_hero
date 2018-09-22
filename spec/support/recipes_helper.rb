def create_recipe(title: 'Recipe title',
                  instructions: 'Recipe instructions',
                  ingredients_count: 2,
                  ingredient_name: 'Ingredient name',
                  ingredient_amount: 20,
                  ingredient_unit: 'Ingredient unit',
                  product_name: 'Product name')
  click_link 'New Recipe'
  fill_in 'Title', with: title
  fill_in 'Instructions', with: instructions
  count = 0
  until count == ingredients_count
    fill_in "name-#{count}", with: "#{ingredient_name} #{count.next}"
    fill_in "amount-#{count}", with: ingredient_amount + count
    fill_in "unit-#{count}", with: "#{ingredient_unit} #{count.next}"
    select("#{product_name}", from: "product-name-#{count}").select_option
    count += 1
  end
  click_button 'Create Recipe'
end

def edit_recipe(recipe)
  fill_in 'Title', with: "#{recipe.title} edit"
  fill_in 'Instructions', with: "#{recipe.instructions} edit"
  count = 0
  until count == recipe.ingredients.size
    fill_in "name-#{count}", with: "name edit #{count.next}"
    fill_in "amount-#{count}", with: recipe.ingredient_lists[count].amount * 2
    fill_in "unit-#{count}", with: "unit edit #{count.next}"
    count += 1
  end
  click_button 'Update Recipe'
end
