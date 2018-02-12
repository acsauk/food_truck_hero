require 'rails_helper'

feature 'Products' do
  scenario 'adding a Product' do
    visit root_path
    click_link(new_product_path)
    fill_in :name, with: name
    fill_in :brand, with: brand
    fill_in :brand, with: unit
    fill_in :amount, with: amount
    fill_in :price, with: price
    click_button 'Create Product'
    expect(page).to have_content 'Product was successfully created'
    expect(page).to have_content 'Name: Product Name'
    expect(page).to have_content 'Brand: Product Brand'
    expect(page).to have_content 'Amount: 2000 grams'
  end
end
