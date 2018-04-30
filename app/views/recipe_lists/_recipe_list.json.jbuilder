json.extract! recipe_list, :id, :recipe_id, :meal_id, :created_at, :updated_at
json.url recipe_list_url(recipe_list, format: :json)
