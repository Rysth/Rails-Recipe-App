class ShoppingListsController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)

    @shopping_list = []
    total_price = 0

    @recipe_foods.each do |recipe_food|
      @shopping_list << { name: recipe_food.food.name, quantity: recipe_food.quantity,
                          measurement_unit: recipe_food.food.measurement_unit, price: recipe_food.food.price }
      total_price += recipe_food.food.price
    end
  end
end
