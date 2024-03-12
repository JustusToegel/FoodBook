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
require 'net/http'
require 'json'
require 'nokogiri'
require 'open-uri'

Ingredient.destroy_all
Meal.destroy_all
User.destroy_all

# Ingredients
# 30.times do
#   ingredient = Ingredient.new(
#     name: Faker::Food.unique.ingredient,
#     size: 200,
#     price: 5
#   )
#   ingredient.save
# end

# Andy User and his Meals

# 10.times do
#   name = Faker::Food.dish
#   andy_meal = Meal.new(
  #     name: name.to_s,
  #     description: "Lovely variation of #{name} that you have never seen before.",
  #     instructions: "To prepare you have to do:#{Faker::Food.description} Let it cook for 45 minutes",
  #     prep_time: 45,
  #     user_id: andy.id
  #   )
  #   andy_meal.save
  #
  #   5.times do
  #     andy_meal_ingredient = MealIngredient.new(
    #       quantity: [1..5].sample,
    #       meal_id: andy_meal.id,
    #       ingredient_id: Ingredient.all.sample.id
    #     )
    #     andy_meal_ingredient.save
    #  end
    # end
andy = User.create(
  email: "andy@gmail.com",
  password: "123456",
  name: "Andy Shi",
  description: "Hobby Cook and Coding Lover",
  bio: "Hi folks! I am Andy and I love to cook. I have plenty of recipes prepared for you and can wait to add even more! Stay tuned for weekly updates and eat like me! At the end, you are what you eat and everybody wants to be like me! So.. let's get cooking ...",
  instagram: "instagram.com",
  you_tube: "youtube.com"
  )
# Seeding User with Meals and Ingredients
# 10.times do
#   user = User.new(
#     email: Faker::Internet.email,
#     password: "123456",
#     name: Faker::Name.name,
#     description: Faker::Job.title,
#     bio: "I love #{Faker::Food.ethnic_category} and have plenty of meals prepared for you to cook.",
#     instagram: "instagram.com",
#     you_tube: "youtube.com"
#   )
#   user.save

#   5.times do
#     name = Faker::Food.dish
#     meal = Meal.new(
#       name: name.to_s,
#       description: "Lovely variation of #{name} that you have never seen before.",
#       instructions: "To prepare you have to do:#{Faker::Food.description} Let it cook for 45 minutes",
#       prep_time: 45,
#       user_id: user.id
#     )
#     meal.save

#     5.times do
#       meal_ingredient = MealIngredient.new(
#         quantity: [1..5].sample,
#         meal_id: meal.id,
#         ingredient_id: Ingredient.all.sample.id
#       )
#       meal_ingredient.save
#     end
#   end
# end

########################################################################
# API

# api_key = "db6a8b3c79944976acd8ca04cd447035"
# uri = URI("https://api.spoonacular.com/recipes/random?number=3&apiKey=#{api_key}")
# # for veggie: URI("https://api.spoonacular.com/recipes/random?number=6&include-tags=vegetarian&apiKey=#{api_key}")
# response = Net::HTTP.get(uri)
# data = JSON.parse(response)

# recipes = data["recipes"]

# recipes.each do |recipe|
#   meal = Meal.create(
#     name: recipe["title"],
#     description: recipe["summary"],
#     instructions: recipe["instructions"],
#     prep_time: recipe["readyInMinutes"],
#     price_serving: recipe["pricePerServing"],
#     category: "vegetarian",
#     user_id: andy.id
#   )
#   file = URI.open(recipe["image"])
#   meal.photo.attach(io: file, filename: "recipe-picture.jpg", content_type: "image/jpg")

#   # add indredients
#   recipe["extendedIngredients"].each do |ingredient|

#     new_ingredient = Ingredient.create(
#       name: search for name of grocerie from map API with servings being recipe["servings"]
#       instruction_name: ingredient["original"],
#       size: 1,
#       price: [2.99, 3.99, 4.99, 2.49, 1.39, 0.99].sample
#     )

#     MealIngredient.new(
#       quantity: recipe["servings"],
#       meal_id: meal.id,
#       ingredient_id: new_ingredient.id
#     )
#   end
# end

##################################################################################################

user_url = "https://randomuser.me/api/?results=2"
user_response = Net::HTTP.get(URI(user_url))
user_data = JSON.parse(user_response)["results"]

user_data.each do |user|
  new_user = User.create(
    email: user["email"],
    password: "123456",
    name: "#{user["name"]["first"]} #{user["name"]["last"]}",
    description: Faker::Job.title,
    bio: "I love #{Faker::Food.ethnic_category} and have plenty of meals prepared for you to cook.",
    instagram: "instagram.com",
    you_tube: "youtube.com"
  )
  file = URI.open(user["picture"]["large"])
  new_user.photo.attach(io: file, filename: "profile-picture.jpg", content_type: "image/jpg")

  2.times do
    diet = ["ketogenic", "vegetarian", "vegan", "pescetarian", "italian"].sample
    api_key = "db6a8b3c79944976acd8ca04cd447035"
    uri = URI("https://api.spoonacular.com/recipes/random?number=1&include-tags=#{diet}&apiKey=#{api_key}")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    recipes = data["recipes"]

    recipes.each do |recipe|
      meal = Meal.create(
        name: recipe["title"],
        description: recipe["summary"],
        instructions: recipe["instructions"],
        prep_time: recipe["readyInMinutes"],
        category: diet,
        user_id: new_user.id,
        servings: recipe["servings"]
      )
      file = URI.open(recipe["image"])
      meal.photo.attach(io: file, filename: "recipe-picture.jpg", content_type: "image/jpg")

      # add indredients
      recipe["extendedIngredients"].each do |ingredient|

        #############################
        ing_uri = URI.parse("https://api.spoonacular.com/food/ingredients/map")
        ing_params = { apiKey: "db6a8b3c79944976acd8ca04cd447035" }
        ing_uri.query = URI.encode_www_form(ing_params)

        # Construct the request object
        ing_http = Net::HTTP.new(ing_uri.host, ing_uri.port)
        ing_http.use_ssl = true

        ing_request = Net::HTTP::Post.new(ing_uri.request_uri)
        ing_request["Content-Type"] = "application/json"

        # Add any required parameters to the request body
        ing_request.body = {
          "ingredients": [ingredient["name"]],
          "servings": recipe["servings"]
        }.to_json

        ing_response = ing_http.request(ing_request)
        title = JSON.parse(ing_response.body)[0]["products"][0]["title"]

        #############################
        new_ingredient = Ingredient.create(
          name: title,
          instruction_name: ingredient["original"],
          size: 1,
          price: [2.99, 3.99, 4.99, 2.49, 1.39, 0.99].sample
        )

        MealIngredient.new(
          quantity: 1,
          meal_id: meal.id,
          ingredient_id: new_ingredient.id
        )
      end
    end
  end
end
