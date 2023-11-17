require 'rails_helper'

RSpec.describe 'Testing food views', type: :feature do
  describe 'Food#index' do
    before(:each) do
      @user = User.create! name: 'Tom', email: 'tom@example.com', password: 'password'
      (1..5).each { |i| @user.foods.create name: "Test Food #{i}", measurement_unit: 'kilograms', price: i }
      login_as(@user, scope: :user)
      visit foods_path
    end

    it 'should list all foods' do
      (1..5).each do |i|
        expect(page).to have_content "Test Food #{i}"
      end
    end
  end
end
