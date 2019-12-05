class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes =  Recipe.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @recipe.ingredient_lists.build.build_ingredient
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    # binding.irb
    @recipe.save

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        @recipe.ingredient_lists.build.build_ingredient
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(
        :title, :instructions, :id, ingredient_lists_attributes: [
          %i[amount unit id _destroy], ingredient_attributes:
            %i[name product_id id]
        ]
      )

      # Parameters: {
      #   "utf8"=>"✓", "authenticity_token"=>"/NTWXWlXRUCUnM+c1f4RKAdG1dr9h3xhtqLFFiSeqKKUPirDKeuJQ5FULAR0I1x3aRzeqgsozFmuoVD1Ftz04w==",
      #   "recipe"=> {
      #       "title"=>"Cheese and Tomato Omlette", "instructions"=>"Cook the omlette", "ingredient_lists_attributes"=> {
      #         "0"=> {
      #           "ingredient_attributes"=> {"product_id"=>"1", "id"=>"1"}, "amount"=>"2.0", "unit"=>"eggs", "_destroy"=>"false", "id"=>"1"},
      #         "1"=> {
      #           "ingredient_attributes"=> {"product_id"=>"2", "id"=>"2"}, "amount"=>"50.0", "unit"=>"Grams", "_destroy"=>"false", "id"=>"2"},
      #         "2"=> {
      #           "ingredient_attributes"=> {"product_id"=>"3", "id"=>"3"}, "amount"=>"100.0", "unit"=>"Grams", "_destroy"=>"1", "id"=>"3"}
      #       }
      #   },
      #   "commit"=>"Update Recipe", "id"=>"1"
      # }

    end
end
