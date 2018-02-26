json.extract! meal, :id, :name, :portions, :price_per_portion, :created_at, :updated_at
json.url meal_url(meal, format: :json)
