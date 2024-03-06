# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Meal.destroy_all
User.destroy_all

andy = User.create(
  email: "andy@gmail.com",
  password: "123456",
  name: "Andy Shi",
  description: "Hobby Cook and Coding Lover",
  bio: "I am Andy and I love to cook. Usually i prefer Burgers but i have plenty f recipes prepared for you!",
  instagram: "instagram.com",
  you_tube: "youtube.com"
)

10.times do
  name = Faker::Food.dish
  meal = Meal.new(
    name: name.to_s,
    description: "Lovely variation of #{name} that you have never seen before.",
    instructions: "To prepare you have to do:#{Faker::Food.description} Let it cook for 45 minutes",
    prep_time: 45,
    user_id: andy.id
  )
  meal.save
end

10.times do
  user = User.new(
    email: Faker::Internet.email,
    password: "123456",
    name: Faker::Name.name,
    description: Faker::Job.title,
    bio: "I love #{Faker::Food.ethnic_category} and have plenty of meals prepared for you to cook.",
    instagram: "instagram.com",
    you_tube: "youtube.com"
  )
  user.save!

  5.times do
    name = Faker::Food.dish
    meal = Meal.new(
      name: name.to_s,
      description: "Lovely variation of #{name} that you have never seen before.",
      instructions: "To prepare you have to do:#{Faker::Food.description} Let it cook for 45 minutes",
      prep_time: 45,
      user_id: user.id
    )
    meal.save!
  end
end


