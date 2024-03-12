require 'json'

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
