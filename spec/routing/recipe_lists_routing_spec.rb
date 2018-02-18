require "rails_helper"

RSpec.describe RecipeListsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/recipe_lists").to route_to("recipe_lists#index")
    end

    it "routes to #new" do
      expect(:get => "/recipe_lists/new").to route_to("recipe_lists#new")
    end

    it "routes to #show" do
      expect(:get => "/recipe_lists/1").to route_to("recipe_lists#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/recipe_lists/1/edit").to route_to("recipe_lists#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/recipe_lists").to route_to("recipe_lists#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/recipe_lists/1").to route_to("recipe_lists#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/recipe_lists/1").to route_to("recipe_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/recipe_lists/1").to route_to("recipe_lists#destroy", :id => "1")
    end

  end
end
