class PublicController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @recipes = Recipe.where(public: true).all
  end
end
