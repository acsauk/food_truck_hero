require 'rails_helper'

RSpec.describe "recipe_lists/new", type: :view do
  before(:each) do
    assign(:recipe_list, RecipeList.new(
      :recipe_id => 1,
      :meal_id => 1
    ))
  end

  it "renders new recipe_list form" do
    render

    assert_select "form[action=?][method=?]", recipe_lists_path, "post" do

      assert_select "input[name=?]", "recipe_list[recipe_id]"

      assert_select "input[name=?]", "recipe_list[meal_id]"
    end
  end
end
