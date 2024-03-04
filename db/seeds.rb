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

User.destroy_all

User.create(
  email: "andy@gmail.com",
  password: "123456",
  first_name: "Andy",
  last_name: "Shi",
  bio: "Hobby Cook and Coding Lover",
  description: "I am Andy and I love to cook. Usually i prefer Burgers but i have plenty f recipes prepared for you!",
  instagram: "instagram.com",
  you_tube: "youtube.com"
)

10.times do
  user = User.new(
    email: Faker::Internet.email,
    password: "123456",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    bio: Faker::Job.title,
    description: "I love #{Faker::Food.ethnic_category} and have plenty of meals prepared for you to cook.",
    instagram: "instagram.com",
    you_tube: "youtube.com"
  )
  user.save
end
