require 'rails_helper'

feature 'Products' do
  scenario 'adding a Product' do
    login_user
    visit root_path
    find("#nav-bar > a[href='#{products_path}']").click
    create_product
    expect(page).to have_content 'Product was successfully created'
    expect(page).to have_content 'Name: Product Name'
    expect(page).to have_content 'Brand: Product Brand'
    expect(page).to have_content 'Price: £20'
    expect(page).to have_content 'Amount: 2000.0 grams'
  end

  scenario 'showing a product details' do
    product = FactoryBot.create :product
    login_user
    visit root_path
    find("#nav-bar > a[href='#{products_path}']").click
    click_on product.name
    expect(page).to have_content "Name: #{product.name}"
    expect(page).to have_content "Brand: #{product.brand}"
    expect(page).to have_content "Price: £#{product.price}"
    expect(page).to have_content "Amount: #{product.amount} #{product.unit}"
  end

  scenario 'showing products index' do
    product = FactoryBot.create :product
    login_user
    visit root_path
    find("#nav-bar > a[href='#{products_path}']").click
    expect(page).to have_content "#{product.name}"
    expect(page).to have_content "#{product.brand}"
    expect(page).to have_content "£#{product.price}"
    expect(page).to have_content "#{product.amount} #{product.unit}"
  end

  scenario 'editing a product - product index' do
    product = FactoryBot.create :product
    login_user
    visit root_path
    find("#nav-bar > a[href='#{products_path}']").click
    find('tr', text: product.name.to_s).click_link 'Edit'
    expect(page).to have_current_path(edit_product_path(product))
    edit_product(product)
    expect(page).to have_content "#{product.name} edit"
    expect(page).to have_content "#{product.brand} edit"
    expect(page).to have_content "£#{product.price.to_i + 1}"
    expect(page).to have_content "#{product.amount + 1} #{product.unit} edit"
  end

  scenario 'editing a product - product show' do
    product = FactoryBot.create :product
    login_user
    visit root_path
    find("#nav-bar > a[href='#{products_path}']").click
    find('tr', text: product.name.to_s).click_link product.name.to_s
    expect(page).to have_current_path(product_path(product))
    click_link 'Edit'
    edit_product(product)
    expect(page).to have_content "#{product.name} edit"
    expect(page).to have_content "#{product.brand} edit"
    expect(page).to have_content "£#{product.price.to_i + 1}"
    expect(page).to have_content "#{product.amount + 1} #{product.unit} edit"
  end

  scenario 'deleting products - product show view' do
    product = FactoryBot.create :product
    login_user
    visit root_path
    find("#nav-bar > a[href='#{products_path}']").click
    find('tr', text: product.name.to_s).click_link product.name.to_s
    click_link 'Delete'
    expect(page).to have_content 'Product was successfully destroyed.'
  end

  scenario 'deleting products - products view' do
    product = FactoryBot.create :product
    login_user
    visit root_path
    find("#nav-bar > a[href='#{products_path}']").click
    find('tr', text: product.name.to_s).click_link product.name.to_s
    delete_link = find("a[href='#{product_path product}']"){ |el| el['data-method'] == 'delete' }
    delete_link.click
    expect(page).not_to have_content delete_link
    expect(page).to have_content 'Product was successfully destroyed.'
  end
end
