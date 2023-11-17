require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before do
    user = User.create!(email: 'test@test.com', name: 'test', password: '123456')
    food = Food.create!(name: 'Food', measurement_unit: 'kilograms', price: 1.0, user:)
    recipe = Recipe.create!(name: 'Recipe', preparation_time: '1', cooking_time: '1',
                            description: 'Recipe description', user:)
    @recipe_food = RecipeFood.create!(food:, recipe:)
  end

  describe 'associations' do
    it { expect(@recipe_food).to belong_to(:food) }
    it { expect(@recipe_food).to belong_to(:recipe) }
  end

  describe 'validations' do
    it { expect(@recipe_food).to validate_presence_of(:food_id) }
    it { expect(@recipe_food).to validate_presence_of(:recipe_id) }
  end

  describe 'instance methods' do
    it 'should return the correct food' do
      expect(@recipe_food.food.name).to eq('Food')
    end

    it 'should return the correct recipe' do
      expect(@recipe_food.recipe.name).to eq('Recipe')
    end
  end
end
