require 'rails_helper'

RSpec.describe "meals/index", type: :view do
  before(:each) do
    assign(:meals, [
      Meal.create!(
        :name => "Name",
        :portions => 2,
        :price_per_portion => 3.5
      ),
      Meal.create!(
        :name => "Name",
        :portions => 2,
        :price_per_portion => 3.5
      )
    ])
  end

  it "renders a list of meals" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
  end
end
