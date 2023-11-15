class RecipeFoodsController < ApplicationController
    before_action :set_recipe_food, only: %i[ show destroy ]
  
    # GET /recipe_foods or /recipe_foods.json
    def index
      @recipe_foods = RecipeFood.all
    end
  
    # GET /recipe_foods/1 or /recipe_foods/1.json
    def show
    end
  
    # GET /recipe_foods/new
    def new
      @recipe_food = RecipeFood.new
      @recipe = Recipe.find(params[:recipe_id])
      @foods = Food.where(user_id: current_user.id)
    end
  
    # POST /recipe_foods or /recipe_foods.json
    def create
      @recipe_food = RecipeFood.new(recipe_food_params)
      @recipe = Recipe.find(params[:recipe_id])
  
      respond_to do |format|
        if @recipe_food.save
          format.html { redirect_to recipe_food_url(@recipe_food), notice: "Food was successfully created." }
          format.json { render :show, status: :created, location: @recipe_food }
          redirect_to recipe_path(@recipe)
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
          redirect_to new_recipe_food_path(@recipe)
        end
      end
    end
  
    # DELETE /recipe_foods/1 or /recipe_foods/1.json
    def destroy
      @recipe_food.destroy!
  
      respond_to do |format|
        format.html { redirect_to recipe_foods_url, notice: "Food was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_recipe_food
        @recipe_food = RecipeFood.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def recipe_food_params
        params.require(:recipe_food).permit(:quantity, :food_id)
      end