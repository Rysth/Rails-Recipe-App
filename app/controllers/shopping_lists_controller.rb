class ShoppingListsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)

    @food_quantity = @recipe_foods.length
    @total_value = @recipe_foods.sum { |recipe_food| recipe_food.food.price * recipe_food.quantity }
  end
end
