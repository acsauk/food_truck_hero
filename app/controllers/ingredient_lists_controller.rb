class IngredientListsController < ApplicationController
  before_action :set_ingredient_list, only: [:show, :edit, :update, :destroy]

  # GET /ingredient_lists
  # GET /ingredient_lists.json
  def index
    @ingredient_lists = IngredientList.all
  end

  # GET /ingredient_lists/1
  # GET /ingredient_lists/1.json
  def show
  end

  # GET /ingredient_lists/new
  def new
    @ingredient_list = IngredientList.new
  end

  # GET /ingredient_lists/1/edit
  def edit
  end

  # POST /ingredient_lists
  # POST /ingredient_lists.json
  def create
    @ingredient_list = IngredientList.new(ingredient_list_params)

    respond_to do |format|
      if @ingredient_list.save
        format.html { redirect_to @ingredient_list, notice: 'Ingredient list was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient_list }
      else
        format.html { render :new }
        format.json { render json: @ingredient_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredient_lists/1
  # PATCH/PUT /ingredient_lists/1.json
  def update
    respond_to do |format|
      if @ingredient_list.update(ingredient_list_params)
        format.html { redirect_to @ingredient_list, notice: 'Ingredient list was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient_list }
      else
        format.html { render :edit }
        format.json { render json: @ingredient_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredient_lists/1
  # DELETE /ingredient_lists/1.json
  def destroy
    @ingredient_list.destroy
    respond_to do |format|
      format.html { redirect_to ingredient_lists_url, notice: 'Ingredient list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient_list
      @ingredient_list = IngredientList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_list_params
      params.require(:ingredientList).permit(ingredient_attributes: %i[id name amount unit])
    end
end
