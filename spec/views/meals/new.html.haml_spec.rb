require 'rails_helper'

RSpec.describe "meals/new", type: :view do
  before(:each) do
    assign(:meal, Meal.new(
      :name => "MyString",
      :portions => 1,
      :price_per_portion => 1.5
    ))
  end

  it "renders new meal form" do
    render

    assert_select "form[action=?][method=?]", meals_path, "post" do

      assert_select "input[name=?]", "meal[name]"

      assert_select "input[name=?]", "meal[portions]"

      assert_select "input[name=?]", "meal[price_per_portion]"
    end
  end
end
