require 'rails_helper'

RSpec.describe "RecipeLists", type: :request do
  describe "GET /recipe_lists" do
    it "works! (now write some real specs)" do
      get recipe_lists_path
      expect(response).to have_http_status(200)
    end
  end
end
