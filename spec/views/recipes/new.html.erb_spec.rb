require 'rails_helper'

RSpec.describe "recipes/new", type: :view, :skip => true do
  before(:each) do
    assign(:recipe, Recipe.new(
      :title => "MyString",
      :instructions => "MyText"
    ))
  end

  it "renders new recipe form" do
    render

    assert_select "form[action=?][method=?]", recipes_path, "post" do

      assert_select "input[name=?]", "recipe[title]"

      assert_select "textarea[name=?]", "recipe[instructions]"
    end
  end
end
