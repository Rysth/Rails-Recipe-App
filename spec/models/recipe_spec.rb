require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods).dependent(:destroy) }
  end

  before do
    user = User.create!(email: 'test@test.com', name: 'test', password: '123456')
    subject.user = user
    subject.save!
  end

  subject { Recipe.new(name: 'Recipe', preparation_time: '1', cooking_time: '1', description: 'Recipe description') }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:preparation_time) }
    it { should validate_presence_of(:cooking_time) }
    it { should validate_presence_of(:description) }
  end

  describe 'instance methods' do
    it 'should return the correct name' do
      expect(subject.name).to eq('Recipe')
    end

    it 'should return the correct preparation time' do
      expect(subject.preparation_time).to eq('1')
    end

    it 'should return the correct cooking time' do
      expect(subject.cooking_time).to eq('1')
    end

    it 'should return the correct description' do
      expect(subject.description).to eq('Recipe description')
    end
  end
end
