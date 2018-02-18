require 'rails_helper'

RSpec.describe "recipe_lists/show", type: :view do
  before(:each) do
    @recipe_list = assign(:recipe_list, RecipeList.create!(
      :recipe_id => 2,
      :meal_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
