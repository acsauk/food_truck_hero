require 'rails_helper'

RSpec.describe "meals/edit", type: :view do
  before(:each) do
    @meal = assign(:meal, Meal.create!(
      :name => "MyString",
      :portions => 1,
      :price_per_portion => 1.5
    ))
  end

  it "renders the edit meal form" do
    render

    assert_select "form[action=?][method=?]", meal_path(@meal), "post" do

      assert_select "input[name=?]", "meal[name]"

      assert_select "input[name=?]", "meal[portions]"

      assert_select "input[name=?]", "meal[price_per_portion]"
    end
  end
end
