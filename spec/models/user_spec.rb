require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create!(email: 'test@test.com', password: '123456', password_confirmation: '123456')
  end

  describe 'associations' do
    it { expect(@user).to have_many(:foods).dependent(:destroy) }
    it { expect(@user).to have_many(:recipes).dependent(:destroy) }
  end

  describe 'validations' do
    it { expect(@user).to validate_presence_of(:email) }
    it { expect(@user).to validate_uniqueness_of(:email).case_insensitive }
    it { expect(@user).to validate_presence_of(:password) }
  end
end
