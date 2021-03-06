require 'rails_helper'

feature 'Products' do
  let(:user) { FactoryBot.create :user }

  before(:each) do
    sign_in_as(email: user.email, password: user.password)
    visit root_path
  end

  scenario 'adding a Product' do
    click_link 'Products'
    create_product(name: 'A product name', brand: 'Some brand', price: '2.50', amount: '250', unit: 'Grams', use_by_days: 3)
    expect(page).to have_content 'Product was successfully created'
    expect(page).to have_content 'A product name'
    expect(page).to have_content 'Some brand'
    expect(page).to have_content '£2.50'
    expect(page).to have_content '250.0 Grams'
  end

  scenario 'showing a product details' do
    product = FactoryBot.create :product
    click_link 'Products'
    click_on product.name
    expect(page).to have_content product.name.to_s
    expect(page).to have_content product.brand.to_s
    expect(page).to have_content "£#{product.price}"
    expect(page).to have_content "#{product.amount} #{product.unit}"
    expect(page).to have_content "#{product.use_by_days} days"
  end

  scenario 'showing products index' do
    product = FactoryBot.create :product
    click_link 'Products'
    expect(page).to have_content product.name.to_s
    expect(page).to have_content product.brand.to_s
    expect(page).to have_content "£#{product.price}"
    expect(page).to have_content "#{product.amount} #{product.unit}"
  end

  scenario 'editing a product - product index' do
    product = FactoryBot.create :product
    click_link 'Products'
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
    click_link 'Products'
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
    click_link 'Products'
    find('tr', text: product.name.to_s).click_link product.name.to_s
    click_link 'Delete'
    expect(page).to have_content 'Product was successfully destroyed.'
  end

  scenario 'deleting products - products view' do
    product = FactoryBot.create :product
    click_link 'Products'
    find('tr', text: product.name.to_s).click_link product.name.to_s
    delete_link = find("a[href='#{product_path product}']"){ |el| el['data-method'] == 'delete' }
    delete_link.click
    expect(page).not_to have_content delete_link
    expect(page).to have_content 'Product was successfully destroyed.'
  end

  context 'searching' do
    scenario 'form' do
      product = FactoryBot.create :product
      product2 = FactoryBot.create :product
      click_link 'Products'
      expect(page).to have_content product2.name.to_s
      fill_in 'search', with: product.name.to_s
      click_button 'Search'
      expect(page).to have_content product.name.to_s
      expect(page).to have_no_content product2.name.to_s
    end

    # TODO work out why webpack isn't loading JS or some other reason for this not working
    xscenario 'inline', js: true do
      product = FactoryBot.create :product
      click_link 'Products'
      fill_in 'search', with: product.name.to_s[0...2], wait:  5
      save_and_open_page
      search_results = find('.results-list')
      expect(search_results).to have_content product.name.to_s
    end
  end

end
