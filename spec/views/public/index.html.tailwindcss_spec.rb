require 'rails_helper'

RSpec.describe 'Testing public recipes view', type: :feature do
  describe 'Public Recipes#index' do
    before(:each) do
      @user = User.create! name: 'Tom', email: 'tom@example.com', password: 'password'
      (1..5).each do |i|
        @user.recipes.create name: "Test Recipe #{i}", public: true, description: 'this is description',
                             preparation_time: '1 hours', cooking_time: '1 days'
      end
      visit root_path
    end

    it 'should list all public recipes' do
      (1..5).each do |i|
        expect(page).to have_content "Test Recipe #{i}"
        expect(page).to have_content 'By: Tom'
        expect(page).to have_link(href: recipe_path(@user.recipes[i - 1]))
      end
    end

    it 'should not require a user to login' do
      expect(page).not_to have_content 'You need to sign in or sign up before continuing.'
    end

    it 'should display total food items and total price for each recipe' do
      @user.recipes.each do |recipe|
        expect(page).to have_content "Total Food Items: #{recipe.recipe_foods.sum(&:quantity)}"
        expect(page).to have_content "Total Price: #{ActionController::Base.helpers.number_to_currency(recipe.recipe_foods.sum do |recipe_food|
                                                                                                         recipe_food.food.price * recipe_food.quantity
                                                                                                       end, precision: 2)}"
      end
    end

    it 'should display a message when there are no public recipes' do
      Recipe.destroy_all
      visit root_path
      expect(page).to have_content 'There are no public recipes.'
    end
  end
end
