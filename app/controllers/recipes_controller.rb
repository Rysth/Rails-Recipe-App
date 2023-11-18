class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[public show]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.where(user_id: current_user.id).all
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  def edit
    unless current_user == @recipe.user
      redirect_to root_path, alert: 'You cannot access it.'
      return
    end
    @foods = Food.all
    @recipe_food = RecipeFood.new
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    unless @recipe.public || current_user == @recipe.user
      redirect_to root_path, alert: 'You cannot access it.'
      return
    end
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  # GET /recipes/public
  def public
    @recipes = Recipe.all.where(public: true)
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    @public = !@recipe.public

    respond_to do |format|
      if @recipe.update(public: @public)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    respond_to do |format|
      if @recipe.destroy
        format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      else
        format.html { redirect_to recipes_url, alert: 'Failed to destroy the recipe.' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
