require 'rails_helper'

RSpec.describe 'Testing user recipes view', type: :feature do
  before(:each) do
    @user = User.create! name: 'Tom', email: 'tom@example.com', password: 'password'
    (1..5).each do |i|
      @user.recipes.create name: "Test Recipe #{i}", description: 'this is description', preparation_time: '1 hours',
                           cooking_time: '1 days'
    end
    login_as(@user)
    visit recipes_path
  end

  it 'should display a welcome message with the user name' do
    expect(page).to have_content 'Welcome! Tom'
  end

  it 'should list all user recipes' do
    (1..5).each do |i|
      expect(page).to have_content "Test Recipe #{i}"
      expect(page).to have_link(href: recipe_path(@user.recipes[i - 1]))
      expect(page).to have_button('Remove')
    end
  end

  it 'should display a message when there are no recipes' do
    Recipe.destroy_all
    visit recipes_path
    expect(page).to have_content 'There are no recipes.'
  end
end
