def create_meal(name: 'Meal name',
                portions: 6,
                price_per_portion: 3.5,
                recipe_title: 'Recipe title')
  find("#nav-bar > a[href='#{meals_path}']").click
  click_link 'New Meal'
  fill_in 'Name', with: name
  fill_in 'Portions', with: portions
  fill_in 'Price per portion', with: price_per_portion
  select(recipe_title, from: 'recipe-title').select_option
  click_button 'Create Meal'
end

def edit_meal(meal, recipe_with_ingredients)
  fill_in 'Name', with: "#{meal.name} edit"
  fill_in 'Portions', with: "#{meal.portions} edit"
  fill_in 'Price per portion', with: "#{meal.price_per_portion} edit"
  select(recipe_with_ingredients.title, from: 'recipe-title').select_option
  click_button 'Update Meal'
end
