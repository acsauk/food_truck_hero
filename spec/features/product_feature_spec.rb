require 'rails_helper'

feature 'Products' do
  scenario 'adding a Product' do
    login_user
    visit root_path
    find("#nav_bar > a[href='#{products_path}']").click
    find("a[href='#{new_product_path}']").click
    fill_in :product_name, with: 'Product Name'
    fill_in :product_brand, with: 'Product Brand'
    fill_in :product_unit, with: 'grams'
    fill_in :product_amount, with: 2000
    fill_in :product_price, with: 20
    click_button 'Create Product'
    expect(page).to have_content 'Product was successfully created'
    expect(page).to have_content 'Name: Product Name'
    expect(page).to have_content 'Brand: Product Brand'
    expect(page).to have_content 'Price: £20.0'
    expect(page).to have_content 'Amount: 2000.0 grams'
  end
end
