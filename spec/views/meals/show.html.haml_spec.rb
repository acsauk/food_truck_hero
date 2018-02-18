require 'rails_helper'

RSpec.describe "meals/show", type: :view do
  before(:each) do
    @meal = assign(:meal, Meal.create!(
      :name => "Name",
      :portions => 2,
      :price_per_portion => 3.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
  end
end
