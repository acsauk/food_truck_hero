require 'rails_helper'
RSpec.describe RecipesController, type: :controller do

  let(:product) { FactoryBot.create :product }
  let!(:user) { FactoryBot.create :user }
  # This should return the minimal set of attributes required to create a valid
  # Recipe. As you add validations to Recipe, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      'title' => 'Ham',
      'instructions' => 'Some ham cooked',
      'ingredientLists_attributes' =>
        { '0' =>
          { 'ingredient_attributes' =>
            { 'name' => 'Pig',
              'product_id' => product.id },
            'amount' => '2000',
            'unit' => 'grams' } }
    }
  end

  let(:invalid_attributes) do
    {
      'title' => '',
      'instructions' => '',
      'ingredientLists_attributes' =>
        { '0' =>
          { 'ingredient_attributes' =>
            { 'name' => '',
              'product_id' =>  '' },
            'amount' => '',
            'unit' => '' } }
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RecipesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      recipe = Recipe.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      recipe = Recipe.create! valid_attributes
      get :show, params: {id: recipe.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      recipe = Recipe.create! valid_attributes
      get :edit, params: {id: recipe.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Recipe" do
        expect {
          post :create, params: {recipe: valid_attributes}, session: valid_session
        }.to change(Recipe, :count).by(1)
      end

      it "redirects to the created recipe" do
        post :create, params: {recipe: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Recipe.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {recipe: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          'title' => 'Well cooked ham',
          'instructions' => 'Some ham cooked for a bit longer',
          'ingredientLists_attributes' =>
            { '0' =>
              { 'ingredient_attributes' =>
                { 'name' => 'Pig',
                  'product_id' => product.id },
                'amount' => '1000',
                'unit' => 'grams' } }
        }
      end

      it "updates the requested recipe" do
        recipe = Recipe.create! valid_attributes
        put :update, params: {id: recipe.to_param, recipe: new_attributes}, session: valid_session
        recipe.reload
      end

      it "redirects to the recipe" do
        recipe = Recipe.create! valid_attributes
        put :update, params: {id: recipe.to_param, recipe: valid_attributes}, session: valid_session
        expect(response).to redirect_to(recipe)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        recipe = Recipe.create! valid_attributes
        put :update, params: {id: recipe.to_param, recipe: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do

    it "destroys the requested recipe" do
      recipe = Recipe.create! valid_attributes
      expect {
        delete :destroy, params: {id: recipe.to_param}, session: valid_session
      }.to change(Recipe, :count).by(-1)
    end

    it "redirects to the recipes list" do
      recipe = Recipe.create! valid_attributes
      delete :destroy, params: {id: recipe.to_param}, session: valid_session
      expect(response).to redirect_to(recipes_url)
    end
  end

end
