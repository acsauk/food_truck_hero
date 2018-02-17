def create_product(name: 'Product Name',
                   brand: 'Product Brand',
                   amount: 2000,
                   unit: 'grams',
                   price: 20)
  find("a[href='#{new_product_path}']").click
  fill_in :product_name, with: name
  fill_in :product_brand, with: brand
  fill_in :product_unit, with: unit
  fill_in :product_amount, with: amount
  fill_in :product_price, with: price
  click_button 'Create Product'
end

def edit_product(product)
  fill_in 'Name', with: "#{product.name} edit"
  fill_in 'Brand', with: "#{product.brand} edit"
  fill_in 'Unit', with: "#{product.unit} edit"
  fill_in 'Amount', with: product.amount + 1
  fill_in 'Price', with: product.price + 1
  click_button 'Update Product'
end
