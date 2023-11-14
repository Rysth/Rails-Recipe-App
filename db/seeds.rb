# Create some users
5.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

# Create some foods for each user
User.all.each do |user|
  5.times do
    user.foods.create!(
      name: Faker::Food.ingredient,
      measurement_unit: Faker::Measurement.metric_volume,
      price: rand(1..10)
    )
  end
end

# Create some recipes for each user
User.all.each do |user|
  3.times do
    recipe = user.recipes.create!(
      name: Faker::Food.dish,
      preparation_time: rand(10..60),
      cooking_time: rand(10..60),
      description: Faker::Food.description,
      public: [true, false].sample
    )

    # Add some foods to each recipe
    3.times do
      recipe.recipe_foods.create!(
        food: user.foods.sample,
        quantity: rand(1..5)
      )
    end
  end
end