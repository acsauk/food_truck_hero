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
