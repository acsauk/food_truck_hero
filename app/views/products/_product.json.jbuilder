json.extract! product, :id, :name, :brand, :unit, :amount, :price, :price_pence, :created_at, :updated_at
json.url product_url(product, format: :json)
