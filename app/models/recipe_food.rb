class RecipeFood < ApplicationRecord
  belongs_to :food
  belongs_to :recipe

  validates :food_id, :recipe_id, presence: true
end
