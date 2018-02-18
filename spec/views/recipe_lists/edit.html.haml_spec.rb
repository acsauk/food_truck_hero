require 'rails_helper'

RSpec.describe "recipe_lists/edit", type: :view do
  before(:each) do
    @recipe_list = assign(:recipe_list, RecipeList.create!(
      :recipe_id => 1,
      :meal_id => 1
    ))
  end

  it "renders the edit recipe_list form" do
    render

    assert_select "form[action=?][method=?]", recipe_list_path(@recipe_list), "post" do

      assert_select "input[name=?]", "recipe_list[recipe_id]"

      assert_select "input[name=?]", "recipe_list[meal_id]"
    end
  end
end
