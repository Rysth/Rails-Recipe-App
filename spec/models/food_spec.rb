require_relative '../rails_helper'

RSpec.describe Food, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods).dependent(:destroy) }
  end

  before do
    user = User.create!(email: 'test@test.com', name: 'test', password: '123456')
    subject.user = user
    subject.save!
  end
  subject { Food.new(name: 'Food', measurement_unit: 'kilograms', price: 1.0) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:measurement_unit) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end

  describe 'instance methods' do
    it 'should return the correct price' do
      expect(subject.price).to eq(1.0)
    end

    it 'should return the correct name' do
      expect(subject.name).to eq('Food')
    end

    it 'should return the correct measurement unit' do
      expect(subject.measurement_unit).to eq('kilograms')
    end
  end
end
