def create_meal(name: 'Meal name',
                portions: 6,
                price_per_portion: 3.5,
                recipe_title: 'Recipe title')
  meal = Meal.create(name: name, portions: portions, price_per_portion_pence: price_per_portion)
end

def edit_meal(meal, recipe_with_ingredients)
  fill_in 'Name', with: "#{meal.name} edit"
  fill_in 'Portions', with: "#{meal.portions} edit"
  fill_in :meal_price_per_portion, with: meal.price_per_portion
  select(recipe_with_ingredients.title, from: 'recipe-title').select_option
  click_button 'Update Meal'
end
