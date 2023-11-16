class PublicController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @recipes = Recipe.includes(:user, recipe_foods: [:food]).where(public: true).all
  end
end
