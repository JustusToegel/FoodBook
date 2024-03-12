require 'faker'
require 'net/http'
require 'json'
require 'nokogiri'
require 'open-uri'

Ingredient.destroy_all
Meal.destroy_all
User.destroy_all

########## basic ingredients ####################
ingjason_data = File.read("db/ingredients.json")
cgptingredients = JSON.parse(ingjason_data)
ingitems = cgptingredients["ingredients"]

ingitems.each do |ingredient|
  Ingredient.create(
    name: ingredient["name"],
    instruction_name: ingredient["name"],
    size: 1,
    price: ingredient["price"]
  )
end
########### End of basic ingredients ################

########### Andy User with Recipes ################################
andy = User.create(
  email: "andy@gmail.com",
  password: "123456",
  name: "Andy Shi",
  description: "Hobby Cook and Coding Lover",
  bio: "Hi folks! I am Andy and I love to cook. I have plenty of recipes prepared for you and can wait to add even more! Stay tuned for weekly updates and eat like me! At the end, you are what you eat and everybody wants to be like me! So.. let's get cooking ...",
  instagram: "instagram.com",
  you_tube: "youtube.com"
  )

jason_data = File.read("db/andyrecipes.json")
andyrecipes = JSON.parse(jason_data)
andyrec = andyrecipes["recipes"]

andyrec.each do |recipe|
  meal = Meal.create(
    name: recipe["name"],
    description: recipe["description"],
    instructions: recipe["instructions"],
    prep_time: [30, 45],
    category: "vegan",
    user_id: andy.id,
    servings: 2
  )
  recipe["ingredients"].each do |ingredient|
    new_ingredient = Ingredient.create(
      name: ingredient["name"],
      instruction_name: ingredient["name"],
      size: 1,
      price: ingredient["price"]
    )
    MealIngredient.create(
      quantity: 1,
      meal_id: meal.id,
      ingredient_id: new_ingredient.id
    )
  end
end
########## end of Andy ######################################

############ Create all other Users with Recipes ##############
user_url = "https://randomuser.me/api/?results=4"
user_response = Net::HTTP.get(URI(user_url))
user_data = JSON.parse(user_response)["results"]

user_data.each do |user|
  new_user = User.create(
    email: user["email"],
    password: "123456",
    name: "#{user["name"]["first"]} #{user["name"]["last"]}",
    description: "#{Faker::Job.unique.title}, #{Faker::Hobby.activity}",
    bio: "My favorite kind of cuisine? #{Faker::Food.ethnic_category}! And I have plenty of Recipes prepared for you!!! Some are simple dishes, some recipes are quite advanced... but I am sure that if you watch my video you can easily do them all! So have FUN.",
    instagram: "instagram.com",
    you_tube: "youtube.com"
  )
  file = URI.open(user["picture"]["large"])
  new_user.photo.attach(io: file, filename: "profile-picture.jpg", content_type: "image/jpg")

  2.times do
    diet = ["ketogenic", "vegetarian", "vegan", "pescetarian", "italian"].sample
    # api_key = "db6a8b3c79944976acd8ca04cd447035" #Justus
    # api_key = "bdad344848004f829dbd01d4f293d060" #Mago
    api_key = "2d3dac26308744f7b8d10bcc305fb34d" #Mago 2
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
        ing_params = { apiKey: api_key }
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

        if JSON.parse(ing_response.body)[0]["products"].size > 0
          title = JSON.parse(ing_response.body)[0]["products"][0]["title"]
        else
          title = "Kerygold Cooking Magic 250ml"
        end
        #############################

        new_ingredient = Ingredient.create(
          name: title,
          instruction_name: ingredient["original"],
          size: 1,
          price: [2.99, 3.99, 4.99, 2.49, 1.39, 0.99].sample
        )

        MealIngredient.create(
          quantity: 1,
          meal_id: meal.id,
          ingredient_id: new_ingredient.id
        )
      end
    end
  end
end
