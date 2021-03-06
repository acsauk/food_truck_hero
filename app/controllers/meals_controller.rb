class MealsController < ApplicationController
  before_action :set_meal, only: %i[show edit update destroy add_to_shopping_list]

  # GET /meals
  # GET /meals.json
  def index
    @q = Meal.ransack(params[:q])
    @meals = @q.result(distinct: true)
    @pagy, @records = pagy(@meals)
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    @current_user = current_user
  end

  # GET /meals/new
  def new
    @meal = Meal.new
    @meal.recipe_lists.build.build_recipe
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    @meal.save

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: 'Meal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_to_shopping_list
    shopping_list = ShoppingList.find_by_id(params[:shopping_list])
    shopping_list.add_meal @meal
    flash[:notice] = "#{@meal.name} added to shopping list"
    redirect_to @meal
  end

  def search
    index
    render :index
  end

  def search_async
    if params[:q].blank?
      return render json: {}
    end

    @q = Meal.ransack(name_cont: params[:q])
    render json: @q.result(distinct: true).limit(10)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_meal
    @meal = Meal.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meal_params
    params.require(:meal).permit(
      :name,
      :portions,
      :price_per_portion_pence,
      :price_per_portion,
      :shopping_list,
      recipe_lists_attributes:
        %i[recipe_id id meal_id]
    )
  end
end
