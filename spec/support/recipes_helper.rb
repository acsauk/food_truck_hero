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
  ingredients_count - 1.times { click_on 'Add Ingredient' }
  fill_in_all_product_fields product_name
  fill_in_in_all_amount_fields ingredient_amount
  fill_in_all_unit_fields ingredient_unit
  click_button 'Create Recipe'
end

def edit_recipe(recipe)
  fill_in 'Title', with: "#{recipe.title} edit"
  fill_in 'Instructions', with: "#{recipe.instructions} edit"
  fill_in_all_product_fields recipe.ingredients.last.product.name
  fill_in_in_all_amount_fields 200
  fill_in_all_unit_fields 'Grams'
  click_button 'Update Recipe'
end

def edit_recipe_remove_ingredient()
  find('div.ingredient', match: :first).click_link 'X'
  click_button 'Update Recipe'
end

def fill_in_all_product_fields(product_name)
  all('select', id: /recipe_ingredient_lists_attributes_.+_ingredient_attributes_product_id/).each do |f| 
    f.select(product_name).select_option
  end
end

def fill_in_in_all_amount_fields(amount)
  all('input', id: /recipe_ingredient_lists_attributes_.+_amount/).each do |f|
    f.set(amount)
  end
end

def fill_in_all_unit_fields(unit)
  all('input', id: /recipe_ingredient_lists_attributes_.+_unit/).each do |f|
    f.set(unit)
  end
end
