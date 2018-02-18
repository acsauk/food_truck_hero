require 'rails_helper'

RSpec.describe "recipe_lists/index", type: :view do
  before(:each) do
    assign(:recipe_lists, [
      RecipeList.create!(
        :recipe_id => 2,
        :meal_id => 3
      ),
      RecipeList.create!(
        :recipe_id => 2,
        :meal_id => 3
      )
    ])
  end

  it "renders a list of recipe_lists" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
